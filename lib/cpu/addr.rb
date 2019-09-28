module CPU
  module ADDR
    def self.accumulator(cpu)
      cpu.accumulator
    end

    def self.immediate(cpu)
      cpu.fetch
    end
  end
end
