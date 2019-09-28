require 'rspec'

require './lib/cpu/cpu'

describe CPU::Cpu do
  let(:cpu) do CPU::Cpu.new end

  it "initializes the accumulators" do
    expect(cpu.accumulator).to eq(0)
    expect(cpu.index_x).to eq(0)
    expect(cpu.index_y).to eq(0)
    expect(cpu.status).to eq(CPU::StatusRegister.new)
    expect(cpu.sp).to eq(0xFD)
  end

  it "peek fetches and increments the PC" do
    cpu.mm.put 0x0000, 0xAA
    cpu.mm.put 0x0001, 0xBB
    cpu.mm.put 0x0002, 0xCC

    cpu.pc = 0

    expect(cpu.fetch).to eq(0xAA)
    expect(cpu.fetch).to eq(0xBB)
    expect(cpu.fetch).to eq(0xCC)
  end

  it "peek resets when overflown" do
    cpu.mm.put 0x0000, 0xAA
    cpu.pc = 0xFFFF

    expect(cpu.fetch).to eq(0x00)
    expect(cpu.fetch).to eq(0xAA)
  end
end
