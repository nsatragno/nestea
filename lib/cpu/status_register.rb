module CPU
  class StatusRegister
    attr_reader :register

    def ==(other)
      other.class == self.class and
        other.register == @register
    end

    def initialize
      @register = 0x34
    end

    def to_s
      @register.to_s
    end
  end
end
