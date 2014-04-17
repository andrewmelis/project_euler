require 'spec_helper'

describe Fibonacci do
  describe "#generate(limit)" do
    it "generates the terms of the fibonacci sequence <= the input limit" do
      expect(Fibonacci.generate(10)).to eq([1,2,3,5,8])
    end
  end

  describe "#evens(limit)" do
    it "generates the even terms <= input limit" do
      expect(Fibonacci.evens(10)).to eq([2,8])
    end
  end

  describe "#sum_evens(limit)" do
    it "sums an input list of evens" do
      expect(Fibonacci.sum_evens(10)).to eq(10)
    end

    it "correctly sums even fibonacci numbers <= 4,000,000" do
      expect(Fibonacci.sum_evens(4000000)).to eq(4613732)
    end
  end
      
  
end
