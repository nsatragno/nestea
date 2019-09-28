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
end
