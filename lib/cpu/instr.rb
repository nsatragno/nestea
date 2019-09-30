require "./lib/util/signed_int.rb"

module CPU
  module INSTR
    def self.adc(cpu, addr)
      operand = addr.call(cpu)
      result = cpu.accumulator + operand + cpu.status.carry

      if result > 0xFF
        cpu.status.carry = true
        result &= 0xFF
      else
        cpu.status.carry = false
      end

      cpu.status.zero = result == 0
      if UTIL.is_negative(cpu.accumulator) and UTIL.is_negative(operand)
        cpu.status.overflow = !UTIL.is_negative(result)
      elsif !UTIL.is_negative(cpu.accumulator) and !UTIL.is_negative(operand)
        cpu.status.overflow = UTIL.is_negative(result)
      else
        cpu.status.overflow = 0
      end
      cpu.status.negative = UTIL.is_negative result
      cpu.accumulator = result
    end
  end
end

