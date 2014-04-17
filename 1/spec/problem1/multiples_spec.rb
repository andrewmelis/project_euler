require 'spec_helper'

describe Multiples do
  describe "#generate" do
    it "outputs a list of factors" do
      expect(Multiples.generate(3,9)).to eq([3,6])
    end
  end

  describe "#union" do
    it "outputs a list of factors with duplicates removed" do
      list_three = Multiples.generate(3,18)
      list_six = Multiples.generate(6,18)
      expect(Multiples.union(list_three,list_six)).to eq([3,6,9,12,15])
    end
  end
end



