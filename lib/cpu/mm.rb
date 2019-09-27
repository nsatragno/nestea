module CPU
  class MM
    def initialize
      @ram = Array.new 2048
    end

    def put(position, value)
      if value > 0xFF or value < 0
        raise "Invalid byte 0x#{value.to_s(16)} at 0x#{position.to_s(16)}"
      end

      case position
      when 0..0x2000
        position = position % 0x0800
        @ram[position] = value
      else
        raise "Unhandled position 0x#{position.to_s(16)}"
      end
    end

    def peek(position)
      case position
      when 0...0x2000
        return @ram[position % 0x0800]
      else
        raise "Unhandled position 0x#{position.to_s(16)}"
      end
    end
  end
end
