require './lib/cpu/mm'
require './lib/cpu/status_register'

module CPU
  class Cpu
    attr_accessor :accumulator
    attr_accessor :index_x
    attr_accessor :index_y
    attr_accessor :status
    attr_accessor :sp
    attr_accessor :pc

    attr_reader :mm

    def initialize
      @accumulator = 0
      @index_x = 0
      @index_y = 0
      @status = StatusRegister.new
      @sp = 0xFD
      @mm = MM.new
      @pc = @mm.peek(0xFFFC) + @mm.peek(0xFFFD) << 8
    end

    def fetch
      result = @mm.peek @pc
      @pc += 1
      @pc &= 0xFFFF
      result
    end
  end
end
