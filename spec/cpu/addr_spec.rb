require 'rspec'

require './lib/cpu/addr'
require './lib/cpu/cpu'

describe CPU::ADDR do
  let(:cpu) do
    cpu = CPU::Cpu.new
    cpu.pc = 0
    cpu.mm.put 0, 0x10
    cpu.mm.put 0x10, 0xFF
    cpu
  end

  it "trying to use implicit raises an error" do
    expect {
      expect(CPU::ADDR.implicit(cpu))
    }.to raise_error "Tried to use the implicit addressing mode."
  end

  it "accumulator returns the value of the accumulator" do
    cpu.accumulator = 0xFE
    expect(CPU::ADDR.accumulator(cpu)).to eq(0xFE)
    expect(cpu.pc).to eq(0x00)
  end

  it "immediate returns the value of the next position" do
    expect(CPU::ADDR.immediate(cpu)).to eq(0x10)
    expect(cpu.pc).to eq(0x01)
  end

  it "zero_page returns the value of the position on 0 + operand" do
    expect(CPU::ADDR.zero_page(cpu)).to eq(0xFF)
    expect(cpu.pc).to eq(0x01)
  end

  it "zero_page_x returns the value on zero page + x + operand" do
    cpu.index_x = 0x05
    cpu.mm.put 0x15, 0xBB
    expect(CPU::ADDR.zero_page_x(cpu)).to eq(0xBB)
    expect(cpu.pc).to eq(0x01)
  end

  it "zero_page_x loops if it overflows" do
    cpu.index_x = 0xF5
    cpu.mm.put 0x05, 0xBB
    expect(CPU::ADDR.zero_page_x(cpu)).to eq(0xBB)
    expect(cpu.pc).to eq(0x01)
  end

  it "zero_page_y returns the value on zero page + y + operand" do
    cpu.index_y = 0x05
    cpu.mm.put 0x15, 0xBB
    expect(CPU::ADDR.zero_page_y(cpu)).to eq(0xBB)
    expect(cpu.pc).to eq(0x01)
  end

  it "zero_page_y loops if it overflows" do
    cpu.index_y = 0xF5
    cpu.mm.put 0x05, 0xBB
    expect(CPU::ADDR.zero_page_y(cpu)).to eq(0xBB)
    expect(cpu.pc).to eq(0x01)
  end

  it "relative returns the next position for 0" do
    cpu.mm.put 0x00, 0x00
    cpu.mm.put 0x01, 0xAB
    expect(CPU::ADDR.relative(cpu)).to eq(0xAB)
    expect(cpu.pc).to eq(0x01)
  end

  it "relative can go back" do
    cpu.pc = 0x10
    cpu.mm.put 0x10, 0xFD # -3, effectively -2 since the PC is incremented.
    cpu.mm.put 0x0E, 0xCA
    expect(CPU::ADDR.relative(cpu)).to eq(0xCA)
    expect(cpu.pc).to eq(0x11)
  end

  it "relative can go forwards" do
    cpu.mm.put 0x00, 0x03 # 3, effectively 4 since the PC is incremented.
    cpu.mm.put 0x04, 0xAC
    expect(CPU::ADDR.relative(cpu)).to eq(0xAC)
    expect(cpu.pc).to eq(0x01)
  end

  it "absolute fetches two positions and addresses in little endian" do
    cpu.mm.put 0x00, 0x20
    cpu.mm.put 0x01, 0x10
    cpu.mm.put 0x1020, 0xAA
    expect(CPU::ADDR.absolute(cpu)).to eq(0xAA)
    expect(cpu.pc).to eq(0x02)
  end

  it "absolute_x adds x to the absolute addressing" do
    cpu.mm.put 0x00, 0x20
    cpu.mm.put 0x01, 0x10
    cpu.mm.put 0x102F, 0xAA
    cpu.index_x = 0x0F
    expect(CPU::ADDR.absolute_x(cpu)).to eq(0xAA)
    expect(cpu.pc).to eq(0x02)
  end

  it "absolute_x overflows" do
    cpu.mm.put 0x00, 0xFF
    cpu.mm.put 0x01, 0xFF
    cpu.index_x = 0x01
    expect(CPU::ADDR.absolute_x(cpu)).to eq(0xFF)
    expect(cpu.pc).to eq(0x02)
  end

  it "absolute_y adds y to the absolute addressing" do
    cpu.mm.put 0x00, 0x20
    cpu.mm.put 0x01, 0x10
    cpu.mm.put 0x102F, 0xAA
    cpu.index_y = 0x0F
    expect(CPU::ADDR.absolute_y(cpu)).to eq(0xAA)
    expect(cpu.pc).to eq(0x02)
  end

  it "absolute_y overflows" do
    cpu.mm.put 0x00, 0xFF
    cpu.mm.put 0x01, 0xFF
    cpu.index_y = 0x01
    expect(CPU::ADDR.absolute_y(cpu)).to eq(0xFF)
    expect(cpu.pc).to eq(0x02)
  end

  it "indirect fetches target address" do
    cpu.mm.put 0x00, 0x01
    cpu.mm.put 0x01, 0x02

    cpu.mm.put 0x0201, 0x20
    cpu.mm.put 0x0202, 0x10

    cpu.mm.put 0x1020, 0xAA

    expect(CPU::ADDR.indirect(cpu)).to eq(0xAA)
    expect(cpu.pc).to eq(0x02)
  end

  it "indirect overflows MSB" do
    cpu.mm.put 0x00, 0xFF
    cpu.mm.put 0x01, 0xFF

    # the target address will be 0xFF00 (from 0x00 and 0xFFFF).
    # we can't write there, so we use a mock to verify and expect 0x00.
    allow(cpu.mm).to receive(:peek).and_call_original
    expect(CPU::ADDR.indirect(cpu)).to eq(0x00)
    expect(cpu.pc).to eq(0x02)
    expect(cpu.mm).to have_received(:peek).with 0xFF00
  end
end
