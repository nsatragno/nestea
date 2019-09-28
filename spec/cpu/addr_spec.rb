require 'rspec'

require './lib/cpu/addr'
require './lib/cpu/cpu'

describe CPU::ADDR do
  let(:cpu) do
    cpu = CPU::Cpu.new
    cpu.pc = 0
    cpu.mm.put 0, 0x10
    cpu
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
end
