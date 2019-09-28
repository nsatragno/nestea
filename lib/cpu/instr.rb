module CPU
  module INSTR
    ADC = do |cpu, addr|
      operand = addr cpu
      result = cpu.accumulator + operand + cpu.status.carry

      if result > 0xFF
        cpu.status.carry = true
        result &= 0xFF
      else
        cpu.status.carry = false
      end

      cpu.status.zero = result == 0
      cpu.status.overflow = result & 0b10000000 != cpu.accumulator & 0b10000000
      cpu.status.negative = result & 0b10000000
    end
  end
end

