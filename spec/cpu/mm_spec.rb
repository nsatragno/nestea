require 'rspec'

require './lib/cpu/mm'

describe CPU::MM do
  let(:mm) do CPU::MM.new end

  it "allows putting and peeking bytes on valid RAM" do
    for i in 0...0x2000
      num = i % 0xFF
      mm.put i, num
      expect(mm.peek i).to eq(num)
    end
  end

  it "raises if trying to set an invalid byte" do
    expect {
      mm.put 0x10, -1
    }.to raise_error "Invalid byte 0x-1 at 0x10"

    expect {
      mm.put 0xFF, 0x100
    }.to raise_error "Invalid byte 0x100 at 0xff"
  end

  it "reflects the memory" do
    for i in 0...0x0800
      mm.put i, i % 0xFF
    end

    for i in 0x0800...0x1000
      num = (i - 0x0800) % 0xFF
      expect(mm.peek i).to eq(num), "expected reflected at 0x#{i.to_s(16)}"
    end

    for i in 0x1000...0x1800
      num = (i - 0x1000) % 0xFF
      expect(mm.peek i).to eq(num), "expected reflected at 0x#{i.to_s(16)}"
    end

    for i in 0x1800...0x2000
      num = (i - 0x1800) % 0xFF
      expect(mm.peek i).to eq(num), "expected reflected at 0x#{i.to_s(16)}"
    end
  end

  it "initializes the memory to 0" do
    (0..0x0800).each do |n|
      expect(mm.peek n).to eq(0)
    end
  end
end
