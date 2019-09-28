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

    def zero
      @register >> 1 & 0b00000001
    end

    def zero=(value)
      if value == 0 or !value
        @register &= 0b11111101
      else
        @register |= 0b00000010
      end
    end

    def overflow
      @register >> 5 & 0b00000001
    end

    def overflow=(value)
      if value == 0 or !value
        @register &= 0b11011111
      else
        @register |= 0b00100000
      end
    end

    def negative
      @register >> 6 & 0b00000001
    end

    def negative=(value)
      if value == 0 or !value
        @register &= 0b10111111
      else
        @register |= 0b01000000
      end
    end
  end
end
