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
      # TODO I don't know if this one wraps on the zero page.
      cpu.mm.peek((cpu.fetch + cpu.index_y) & 0xFF)
    end

    def self.relative(cpu)
      cpu.mm.peek(UTIL.signed_int(cpu.fetch) + cpu.pc)
    end

    def self.absolute(cpu)
      cpu.mm.peek(fetch_address(cpu))
    end

    def self.absolute_x(cpu)
      cpu.mm.peek((fetch_address(cpu) + cpu.index_x) & 0xFFFF)
    end

    def self.absolute_y(cpu)
      cpu.mm.peek((fetch_address(cpu) + cpu.index_y) & 0xFFFF)
    end

    def self.indirect(cpu)
      target = fetch_address(cpu)
      addr = cpu.mm.peek(target) + ((cpu.mm.peek(target + 1 & 0xFFFF)) << 8)
      cpu.mm.peek(addr)
    end

    def self.indexed_indirect(cpu)
      target = (cpu.fetch + cpu.index_x) & 0xFF
      addr = cpu.mm.peek(target) + ((cpu.mm.peek(target + 1 & 0xFFFF)) << 8)
      cpu.mm.peek(addr)
    end

    def self.indirect_indexed(cpu)
      target = cpu.fetch
      addr = cpu.mm.peek(target) + ((cpu.mm.peek(target + 1)) << 8)
      cpu.mm.peek((addr + cpu.index_y) & 0xFFFF)
    end

    private
    def self.fetch_address(cpu)
      cpu.fetch + (cpu.fetch << 8)
    end
  end
end
