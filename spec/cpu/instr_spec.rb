require 'rspec'

require './lib/cpu/addr'
require './lib/cpu/cpu'
require './lib/cpu/instr'
require './lib/util/signed_int'

describe CPU::INSTR do
  let(:cpu) do
    cpu = CPU::Cpu.new
    cpu.pc = 0
    cpu
  end

  let(:addr) do
    addr = double("addr")
    allow(addr).to receive(:call) do |cpu|
      @operand
    end
    addr
  end

  it "adc adds normally when there is no carry" do
    cpu.status.carry = 0
    cpu.accumulator = 0x10
    @operand = 0x11

    CPU::INSTR.adc(cpu, addr)
    expect(cpu.accumulator).to eq(0x21)
    expect(cpu.status.carry).to eq(0)
    expect(cpu.status.zero).to eq(0)
    expect(cpu.status.negative).to eq(0)
    expect(cpu.status.overflow).to eq(0)
  end

  it "adc adds with the carry" do
    cpu.status.carry = 1
    cpu.accumulator = 0x10
    @operand = 0x11

    CPU::INSTR.adc(cpu, addr)
    expect(cpu.accumulator).to eq(0x22)
    expect(cpu.status.carry).to eq(0)
    expect(cpu.status.zero).to eq(0)
    expect(cpu.status.negative).to eq(0)
    expect(cpu.status.overflow).to eq(0)
  end

  it "adc adds negative numbers with the carry" do
    cpu.status.carry = 1
    cpu.accumulator = UTIL.byte_from_signed_int -0x10
    @operand = UTIL.byte_from_signed_int -0x20

    CPU::INSTR.adc(cpu, addr)
    expect(cpu.accumulator).to eq(UTIL.byte_from_signed_int -0x2F)
    expect(cpu.status.carry).to eq(1)
    expect(cpu.status.zero).to eq(0)
    expect(cpu.status.negative).to eq(1)
    expect(cpu.status.overflow).to eq(0)
  end

  it "adc sets zero and carry" do
    cpu.status.carry = 1
    cpu.accumulator = 0xFE # -2
    @operand = 0x1

    CPU::INSTR.adc(cpu, addr)
    expect(cpu.accumulator).to eq(0x0)
    expect(cpu.status.carry).to eq(1)
    expect(cpu.status.zero).to eq(1)
    expect(cpu.status.negative).to eq(0)
    expect(cpu.status.overflow).to eq(0)
  end

  it "adc sets overflow when adding positive numbers" do
    cpu.status.carry = 1
    cpu.accumulator = 0x7E
    @operand = 0x7E

    CPU::INSTR.adc(cpu, addr)
    expect(cpu.accumulator).to eq(0xFD)
    expect(cpu.status.carry).to eq(0)
    expect(cpu.status.zero).to eq(0)
    expect(cpu.status.negative).to eq(1)
    expect(cpu.status.overflow).to eq(1)
  end

  it "adc sets overflow when adding negative numbers" do
    cpu.status.carry = 0
    cpu.accumulator = 0xFD # -3
    @operand = 0x82 # -126

    CPU::INSTR.adc(cpu, addr)
    expect(cpu.accumulator).to eq(0x7F)
    expect(cpu.status.carry).to eq(1)
    expect(cpu.status.zero).to eq(0)
    expect(cpu.status.negative).to eq(0)
    expect(cpu.status.overflow).to eq(1)
  end
end
