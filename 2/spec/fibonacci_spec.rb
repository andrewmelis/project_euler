require 'spec_helper'

describe Fibonacci do
  let(:first_10_fib) { Fibonacci.new.take_while { |term| term <= 10} }

  context "sequence generation" do
    it "generates the terms of the fibonacci sequence <= the input limit" do
      expect(first_10_fib).to eq([0,1,1,2,3,5,8])
    end
  end

  context "evens" do
    let(:evens) { first_10_fib.select { |term| term.even? } }

    it "generates the even terms <= 10" do
      expect(evens).to eq([0,2,8])
    end

    it "sums the evens <= 10" do
      expect(evens.inject(:+)).to eq(10)
    end

    it "correctly sums even fibonacci numbers <= 4,000,000" do
      upto_4_mil = Fibonacci.new.take_while { |term| term <= 4000000 }.select { |term| term.even? }.inject(:+)
      expect(upto_4_mil).to eq(4613732)
    end

  end


end
