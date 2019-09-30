require 'rspec'

require './lib/util/signed_int.rb'

describe "UTIL.signed_int" do
  it "converts 0 - 0x7F to positive integers" do
    (0..0x7F).each do |n|
      expect(UTIL.signed_int(n)).to eq(n)
    end
  end

  it "converts 0x80 - 0xFF to negative integers" do
    expected = -1
    0xFF.downto(0x80).each do |n|
      expect(UTIL.signed_int(n)).to eq(expected)
      expected -= 1
    end
  end

  it "raises an error if the byte is out of range" do
    expect {
      UTIL.signed_int(0x100)
    }.to raise_error "Input 0x100 is not a byte"

    expect {
      UTIL.signed_int(-1)
    }.to raise_error "Input 0x-1 is not a byte"
  end
end

describe "UTIL.byte_from_signed_int" do
  it "converts 0 - 0x7F to positive integers" do
    (0..0x7F).each do |n|
      expect(UTIL.byte_from_signed_int(n)).to eq(n)
    end
  end

  it "converts -1 - -0x80 to 0xFF - 0x80" do
    expected = 0xFF
    -1.downto(-0x80).each do |n|
      expect(UTIL.byte_from_signed_int(n)).to eq(expected)
      expected -= 1
    end
  end

  it "raises an error if the int is out of range" do
    expect {
      UTIL.byte_from_signed_int(0x80)
    }.to raise_error "Input 0x80 is out of range"

    expect {
      UTIL.byte_from_signed_int(-0x81)
    }.to raise_error "Input 0x-81 is out of range"
  end
end

describe "is_negative" do
  it "returns false for 0" do
    expect(UTIL.is_negative(0)).to eq(false)
  end

  it "returns true for -1" do
    expect(UTIL.is_negative(0xFF)).to eq(true)
  end

  it "returns true for -128" do
    expect(UTIL.is_negative(0x80)).to eq(true)
  end

  it "returns false for 1" do
    expect(UTIL.is_negative(0x01)).to eq(false)
  end

  it "returns false for 127" do
    expect(UTIL.is_negative(0x7F)).to eq(false)
  end
end
