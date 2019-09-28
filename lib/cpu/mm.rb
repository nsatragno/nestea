module CPU
  class MM
    def initialize
      @ram = Array.new 0x0800
      # TODO read from cartridge.
      @rom = Array.new 0xBFE0

      (0..0x0800).each do |n|
        @ram[n] = 0
      end

      (0xBFE0..0xFFFF).each do |n|
        @rom[n] = 0
      end
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
      when 0x4020..0xFFFF
        return @rom[position]
      else
        raise "Unhandled position 0x#{position.to_s(16)}"
      end
    end
  end
end
