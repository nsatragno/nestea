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

  describe "immediate" do
    it "returns the value of the next position" do
      expect(CPU::ADDR.immediate(cpu)).to eq(0x10)
      expect(cpu.pc).to eq(0x01)
    end
  end
end
