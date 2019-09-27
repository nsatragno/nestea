require 'rspec'

require './lib/cpu/status_register'

describe CPU::StatusRegister do
  let(:status) do CPU::StatusRegister.new end

  it "initializes at the correct value " do
    expect(status.register).to eq(0x34)
  end

  describe "equality comparison" do
    it "treats equal registers as equal" do
      expect(status).to eq(CPU::StatusRegister.new)
      status.register = 0x10
      expect(status).to eq(CPU::StatusRegister.new(0x10))
    end

    it "treats equal integer literals as equal" do
      expect(CPU::StatusRegister.new(0x10)).to eq(0x10)
    end

    it "treats different integer literals as different" do
      expect(CPU::StatusRegister.new(0x10)).not_to eq(0x11)
    end

    it "treats different registers as different" do
      expect(status).not_to eq(CPU::StatusRegister.new(0x42))
    end

    it "treats different classes as different" do
      expect(status).not_to eq(String.new)
    end
  end
end
