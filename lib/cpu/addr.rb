module CPU
  module ADDR
    def self.implicit(cpu)
      raise "Tried to use the implicit addressing mode."
    end

    def self.accumulator(cpu)
      cpu.accumulator
    end

    def self.immediate(cpu)
      cpu.fetch
    end
  end
end
