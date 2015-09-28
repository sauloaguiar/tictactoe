require 'spec_helper'

describe Challenge::Board do

  # before :each will run before every test; could be :all to run once
  before do
    @board = Challenge::Board.new
  end

  # describe says we’re describing the actions of a specific method
  describe "#new" do
    it "takes no parameter and return a Board object" do
      expect(@board).to be_an_instance_of Challenge::Board
    end
  end

  describe "#cells" do
    it "contains an string array with positions" do
      expected = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
      expect(@board.cells).to be_an_instance_of Array
      expect(@board.cells).to eq expected
    end
  end

  # http://stackoverflow.com/questions/4775724/is-it-possible-to-have-parameterized-specs-in-rspec
  describe "#fill_position" do
    0.step(8,1) do |choice|
      it "should fill position #{choice} in the board" do
        expected = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
        expected[choice] = "X"
        @board.fill_position!(choice, "X")
        expect(@board.cells).to eq expected
      end
    end

    0.step(8,1) do |choice|
      it "should not fill the taken position #{choice}" do
        expected = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
        expected[choice] = "X"
        @board.fill_position!(choice, "X")
        @board.fill_position!(choice, "O")
        expect(@board.cells).to eq expected
      end
    end
  end

  describe "#checks for tie" do
    context "with X's marker" do
      let(:board) {
        board = Challenge::Board.new(["X", "X", "X", "X", "X", "X", "X", "X", "X"])
        board
      }
      it "should answer if the board has all positions filled" do
        expect(board.tie).to be true
      end
    end
    context "with O's marker" do
      let(:board) {
        board = Challenge::Board.new(["O", "O", "O", "O", "O", "O", "O", "O", "O"])
        board
      }
      it "should answer if the board has all positions filled" do
        expect(board.tie).to be true
      end
    end

  end


# let
# shared contexts
# shared examples
  describe "#checks for victory" do
    context "in rows" do
      let(:board123) {
        board = Challenge::Board.new(["X", "X", "X", "3", "4", "5", "6", "7", "8"])
        board
      }
      let(:board456) {
        board = Challenge::Board.new(["0", "1", "2", "X", "X", "X", "6", "7", "8"])
        board
      }
      it "should find a entry victory line in [0,1,2]" do
        expect(board123.victoryEntry).to eq [0,1,2]
      end
      it "should fine a entry victory line in [3,4,5]" do
        expect(board456.victoryEntry).to eq [3,4,5]
      end
    end
    context "in cols" do

    end
  end
end
