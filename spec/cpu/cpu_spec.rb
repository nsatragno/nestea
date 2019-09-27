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
end
