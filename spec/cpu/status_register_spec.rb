require 'rspec'

require './lib/cpu/status_register'

describe CPU::StatusRegister do
  let(:status) do CPU::StatusRegister.new end

  it "initializes at the correct value " do
    expect(status.register).to eq(0x34)
  end

  it "gets the carry" do
    status.register = 0b00000000
    expect(status.carry).to eq 0

    status.register = 0b00000001
    expect(status.carry).to eq 1

    status.register = 0b11111110
    expect(status.carry).to eq 0

    status.register = 0b11111111
    expect(status.carry).to eq 1
  end

  it "sets the carry" do
    status.register = 0b00000000
    status.carry = 1
    expect(status.register).to eq 0b00000001

    status.carry = true
    expect(status.register).to eq 0b00000001

    status.carry = 0
    expect(status.register).to eq 0b00000000

    status.carry = false
    expect(status.register).to eq 0b00000000
  end

  it "gets the zero" do
    status.register = 0b00000000
    expect(status.zero).to eq 0

    status.register = 0b00000010
    expect(status.zero).to eq 1

    status.register = 0b11111101
    expect(status.zero).to eq 0

    status.register = 0b11111111
    expect(status.zero).to eq 1
  end

  it "sets the zero" do
    status.register = 0b00000000
    status.zero = 1
    expect(status.register).to eq 0b00000010

    status.zero = true
    expect(status.register).to eq 0b00000010

    status.zero = 0
    expect(status.register).to eq 0b00000000

    status.zero = false
    expect(status.register).to eq 0b00000000
  end

  it "gets the overflow" do
    status.register = 0b00000000
    expect(status.overflow).to eq 0

    status.register = 0b00100000
    expect(status.overflow).to eq 1

    status.register = 0b11011111
    expect(status.overflow).to eq 0

    status.register = 0b11111111
    expect(status.overflow).to eq 1
  end

  it "sets the overflow" do
    status.register = 0b00000000
    status.overflow = 1
    expect(status.register).to eq 0b00100000

    status.overflow = true
    expect(status.register).to eq 0b00100000

    status.overflow = 0
    expect(status.register).to eq 0b00000000

    status.overflow = false
    expect(status.register).to eq 0b00000000
  end

  it "gets the negative" do
    status.register = 0b00000000
    expect(status.negative).to eq 0

    status.register = 0b01000000
    expect(status.negative).to eq 1

    status.register = 0b10111111
    expect(status.negative).to eq 0

    status.register = 0b11111111
    expect(status.negative).to eq 1
  end

  it "sets the negative" do
    status.register = 0b00000000
    status.negative = 1
    expect(status.register).to eq 0b01000000

    status.negative = true
    expect(status.register).to eq 0b01000000

    status.negative = 0
    expect(status.register).to eq 0b00000000

    status.negative = false
    expect(status.register).to eq 0b00000000
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
