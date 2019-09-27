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
  end
end
