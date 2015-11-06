require 'spec_helper'

describe Challenge::Board do

  # before :each will run before every test; could be :all to run once
  before do
    @board = Challenge::Board.new
  end

  # describe says we’re describing the actions of a specific method
  describe "#initialize" do
    context "When it is created without argument" do
      let(:board){
        Challenge::Board.new
      }
      it "has 3 as default size" do
        expect(board).to be_an_instance_of Challenge::Board
      end
      it "Then contains an string array with positions" do
        expected = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
        expect(board.cells).to be_an_instance_of Array
        expect(board.cells).to eq expected
      end
    end
    context "When passing an argument" do
      let(:board){
        Challenge::Board.new(4)
      }
      it "should contain a correspondent array" do
        expected = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15"]
        expect(board.cells).to be_an_instance_of Array
        expect(board.cells).to eq expected
      end
    end
  end

  # http://stackoverflow.com/questions/4775724/is-it-possible-to-have-parameterized-specs-in-rspec
  describe "#fill_position" do
    context "When filling all the positions" do
      0.step(8,1) do |choice|
        it "Then has the position #{choice} correctly assigned" do
          expected = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
          expected[choice] = "X"
          @board.fill_position!(choice, "X")
          expect(@board.cells).to eq expected
        end
      end
    end

    context "When the position was already taken" do
      0.step(8,1) do |choice|
        it "Then hasn't the position #{choice} changed" do
          expected = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
          expected[choice] = "X"
          @board.fill_position!(choice, "X")
          @board.fill_position!(choice, "O")
          expect(@board.cells).to eq expected
        end
      end
    end
  end

  describe "#get_victory_entries" do
    context "in rows" do
      it "should produce lines following the board size" do
        board = Challenge::Board.new(3)
        expect(board.get_victory_rows()[0]).to eq [0, 1, 2]
        expect(board.get_victory_rows()[1]).to eq [3, 4, 5]
        expect(board.get_victory_rows()).not_to include([0, 0, 0])

        board = Challenge::Board.new(4)
        expect(board.get_victory_rows()[0]).to eq [0, 1, 2, 3]
        expect(board.get_victory_rows()[1]).to eq [4, 5, 6, 7]
        expect(board.get_victory_rows()).not_to include([0, 0, 0, 0])
      end
    end

    context "in cols" do
      it "should produce lines following board size" do
        board = Challenge::Board.new(3)
        expect(board.get_victory_cols()[0]).to eq [0, 3, 6]
        expect(board.get_victory_cols()[1]).to eq [1, 4, 7]
        expect(board.get_victory_cols()).not_to include([0, 0, 0])

        board = Challenge::Board.new(4)
        expect(board.get_victory_cols()[0]).to eq [0, 4, 8, 12]
        expect(board.get_victory_cols()[1]).to eq [1, 5, 9, 13]
        expect(board.get_victory_cols()).not_to include([0, 0, 0, 0])
      end
    end

    context "diagonals" do
      it "should get the diagonal following the board size" do
        board = Challenge::Board.new(3)
        expect(board.get_victory_diagonals()[0]).to eq [0, 4, 8]
        expect(board.get_victory_diagonals()[1]).to eq [2, 4, 6]
        expect(board.get_victory_diagonals()).not_to include([0, 0, 0])

        board = Challenge::Board.new(4)
        expect(board.get_victory_diagonals()[0]).to eq [0, 5, 10, 15]
        expect(board.get_victory_diagonals()[1]).to eq [3, 6, 9, 12]
        expect(board.get_victory_diagonals()).not_to include([0, 0, 0, 0])

        board = Challenge::Board.new(5)
        expect(board.get_victory_diagonals()[0]).to eq [0, 6, 12, 18, 24]
        expect(board.get_victory_diagonals()[1]).to eq [4, 8, 12, 16, 20]
        expect(board.get_victory_diagonals()).not_to include([0, 0, 0, 0, 0])
      end
    end

    context "all entries" do
      it "should contain all entries together" do
        board = Challenge::Board.new(3)
        expect(board.get_victory_entries()).to include([0, 1, 2])
        expect(board.get_victory_entries()).to include([0, 3, 6])
        expect(board.get_victory_entries()).to include([0, 4, 8])
        expect(board.get_victory_entries()).not_to include([0, 0, 0])

        board = Challenge::Board.new(4)
        expect(board.get_victory_entries()).to include([0, 1, 2, 3])
        expect(board.get_victory_entries()).to include([0, 4, 8, 12])
        expect(board.get_victory_entries()).to include([3, 6, 9, 12])
        expect(board.get_victory_entries()).not_to include([0, 0, 0, 0])

        board = Challenge::Board.new(5)
        expect(board.get_victory_entries()).to include([0, 1, 2, 3, 4])
        expect(board.get_victory_entries()).to include([4, 8, 12, 16, 20])
        expect(board.get_victory_entries()).not_to include([0, 0, 0, 0, 0])
      end
    end
  end

  describe "#tie" do
    context "all markers are X" do
      it "should be tied" do
        board = Challenge::Board.new
        for i in 0..8 do
          board.fill_position!(i, "X")
        end
        expect(board.tie?).to be true
      end
    end
    context "all markers are O" do
      it "should be tied" do
        board = Challenge::Board.new
        for i in 0..8 do
          board.fill_position!(i, "O")
        end
        expect(board.tie?).to be true
      end
    end
  end

  describe "#winner" do
    context "3 size board" do
      it "should get the winner for a diagonal" do
        board = Challenge::Board.new
        board.fill_position!(0, "X")
        board.fill_position!(4, "X")
        board.fill_position!(8, "X")
        expect(board.winner).to eq "X"
      end
      it "should find winner for a column"  do
        board = Challenge::Board.new
        board.fill_position!(0, "X")
        board.fill_position!(3, "X")
        board.fill_position!(6, "X")
        expect(board.winner).to eq "X"
      end
      it "should not find a winner" do
        board = Challenge::Board.new
        board.fill_position!(1, "X")
        expect(board.winner).to eq false
      end
      it "should not find a winner" do
        board = Challenge::Board.new
        board.fill_position!(2, "X")
        board.fill_position!(6, "X")
        expect(board.winner).to eq false
      end
      it "should not find a winner" do
        board = Challenge::Board.new
        board.fill_position!(0, "O")
        board.fill_position!(3, "O")
        board.fill_position!(6, "O")
        expect(board.winner).to eq "O"
      end
      it "should not find a winner" do
        board = Challenge::Board.new
        board.fill_position!(0, "X")
        board.fill_position!(2, "X")
        board.fill_position!(5, "X")
        board.fill_position!(6, "O")
        board.fill_position!(8, "O")
        expect(board.winner).to eq false
      end
      it "should not find a winner" do
        board = Challenge::Board.new
        board.fill_position!(0, "O")
        board.fill_position!(1, "X")
        board.fill_position!(3, "O")
        board.fill_position!(4, "X")
        board.fill_position!(5, "X")
        board.fill_position!(8, "O")
        expect(board.winner).to eq false
      end
      it "should not find a winner" do
        board = Challenge::Board.new
        board.fill_position!(0, "X")
        board.fill_position!(1, "X")
        board.fill_position!(2, "O")
        board.fill_position!(3, "O")
        board.fill_position!(4, "X")
        board.fill_position!(5, "X")
        board.fill_position!(6, "X")
        board.fill_position!(7, "O")
        board.fill_position!(8, "O")
        expect(board.winner).to eq false
      end

    end
    context "4 sized board" do
      it "should get the winner for diagonal"  do
        board = Challenge::Board.new(4)
        board.fill_position!(0, "X")
        board.fill_position!(5, "X")
        board.fill_position!(10, "X")
        board.fill_position!(15, "X")
        expect(board.winner).to eq "X"
      end
      it "should get the winner for a column" do
        board = Challenge::Board.new(4)
        board.fill_position!(0, "X")
        board.fill_position!(4, "X")
        board.fill_position!(8, "X")
        board.fill_position!(12, "X")
        expect(board.winner).to eq "X"
      end
      it "should not find a winner" do
        board = Challenge::Board.new(4)
        board.fill_position!(1, "X")
        expect(board.winner).to eq false
      end
    end
  end

  describe "#highest_index" do
    context "in a 3 by 3 board" do
      it "should return 8" do
        board = Challenge::Board.new
        expect(board.highest_index).to eq 8
      end
    end
    context "in a 4 by 4 board" do
      it "should return 15" do
        board = Challenge::Board.new(4)
        expect(board.highest_index).to eq 15
      end
    end
  end

  describe "#is_available?" do
    context "in a 3 by 3 board" do
      it "should get that the position is not available" do
        board = Challenge::Board.new
        board.fill_position!(1, "X")
        expect(board.is_available?(1)).to eq false
      end
    end

    context "in a 4 by 4 board" do
      it "should get that the position is not available" do
        board = Challenge::Board.new(4)
        expect(board.is_available?(10)).to eq true
      end
    end
  end
end
