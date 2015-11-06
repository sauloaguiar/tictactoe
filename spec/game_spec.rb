require_relative 'spec_helper'

require_relative '../lib/player'
require_relative '../lib/board'
require_relative '../lib/console'
require_relative '../lib/setup'

describe Challenge::Game do

  let(:board) { double( "board", winner: nil, tie?: false) }
  let(:ui) { double("ui", tie: nil, welcome: nil, turn_message: nil , print_board: nil, end_game: nil ) }
  let(:setup) { Challenge::Setup.new(ui) }
  let(:human) { double("human", marker: 'X', move: 3) }
  let(:ai) { double("ai", marker: 'O', move: 5) }
  let(:game) { Challenge::Game.new(board, human, ai, ui) }

  describe "starting the game" do
    it "prints the welcome message, asks for players markers and order" do
      expect(ui).to receive(:welcome)
      allow(ui).to receive(:get_player_marks).and_return( "X, O" )
      allow(ui).to receive(:get_player_order).and_return( nil )
      setup.run
    end

    it "calls the print board function" do
      expect(ui).to receive(:print_board)
      allow(board).to receive(:over?).and_return(false)
      game.start_game
    end
  end

  describe "displaying a winner" do
    it "shows a win if the game was won" do
      allow(board).to receive(:winner).and_return(false, human.marker)
      allow(board).to receive(:is_available?).and_return(true, true)
      allow(board).to receive(:fill_position!)

      expect(ui).to receive(:win).with(human)
      expect(ui).to receive(:end_game)
      game.start_game
    end

    it "identifies the correct winner" do
      allow(board).to receive(:winner).and_return(human.marker)
      game.start_game
      expect(board.winner).to eq(human.marker)
    end
  end

  describe "displaying a draw" do
    it "shows a draw message" do
      #allow(board).to receive(:over?).and_return(false, true)
      allow(board).to receive(:tie?).and_return(true)
      #allow(board).to receive(:is_available?).and_return(true, true)
      #allow(board).to receive(:fill_position!)

      game.start_game
      expect(ui).to receive(:tie)
      expect(ui).to receive(:end_game)
    end
  end

  # it makes the next players next move

  # it shows a tie if the game is a tie
  # it changes players after the move

end
