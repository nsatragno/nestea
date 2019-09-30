module UTIL
  def self.signed_int(byte)
    raise "Input 0x#{byte.to_s(16)} is not a byte" if byte > 0xFF or byte < 0
    return byte if byte < 0x80
    byte - 0xFF - 1
  end

  def self.byte_from_signed_int(int)
    raise "Input 0x#{int.to_s(16)} is out of range" if int > 0x7F or int < -0x80
    return int if int >= 0
    int + 0xFF + 1
  end

  def self.is_negative(byte)
    (byte & 0b10000000) != 0
  end
end
