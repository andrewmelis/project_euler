require 'spec_helper'

describe Solver do
  describe "#initialize" do
    context "project euler problem #54" do
      it "correctly counts 376" do
	expect(Solver.new('./lib/poker.txt').p1_win_count).to eq(376)
      end
    end
  end
end

