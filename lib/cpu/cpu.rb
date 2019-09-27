require './lib/cpu/status_register'

module CPU
  class Cpu
    attr_reader :accumulator
    attr_reader :index_x
    attr_reader :index_y
    attr_reader :status
    attr_reader :sp

    def initialize
      @accumulator = 0
      @index_x = 0
      @index_y = 0
      @status = StatusRegister.new
      @sp = 0xFD
    end
  end
end
