require 'spec_helper'

describe Challenge::Console do

  let(:input) { StringIO.new }
  let(:output) { StringIO.new }
  let(:console) { Challenge::Console.new(input, output) }

  describe "#print_board" do
    context "board size 3" do
      it "should print the board as expected" do
        board = Challenge::Board.new
        console.print_board(board)

        expect(input.readlines).to eq("String representation of board")
      end
    end
  end
end
