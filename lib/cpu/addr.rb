require './lib/util/signed_int.rb'

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

    def self.zero_page(cpu)
      cpu.mm.peek(cpu.fetch)
    end

    def self.zero_page_x(cpu)
      cpu.mm.peek((cpu.fetch + cpu.index_x) & 0xFF)
    end

    def self.zero_page_y(cpu)
      cpu.mm.peek((cpu.fetch + cpu.index_y) & 0xFF)
    end

    def self.relative(cpu)
      cpu.mm.peek(UTIL.signed_int(cpu.fetch) + cpu.pc)
    end
  end
end
