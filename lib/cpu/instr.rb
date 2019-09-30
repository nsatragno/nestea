require "./lib/util/signed_int.rb"

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
      cpu.status.overflow =
        Util.is_negative(result) != Util.is_negative(cpu.accumulator)
      cpu.status.negative = Util.is_negative result
    end
  end
end

