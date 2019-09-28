module CPU
  class StatusRegister
    attr_accessor :register

    def ==(other)
      other.class == self.class and
        other.register == @register or other == @register
    end

    def initialize(initial_value = 0x34)
      @register = initial_value
    end

    def to_s
      @register.to_s
    end

    def carry
      @register & 0b00000001
    end

    def carry=(value)
      if value == 0 or !value
        @register &= 0b11111110
      else
        @register |= 0b00000001
      end
    end
  end
end
