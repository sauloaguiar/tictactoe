require_relative 'spec_helper'

require_relative '../lib/player'
require_relative '../lib/board'
require_relative '../lib/console'
require_relative '../lib/setup'

describe Challenge::Game do

  let(:board) { double( "board", win?:false, winner: nil, tie?: false, over?:true, is_available?:true, fill_position!:nil) }
  let(:ui) { double("ui", tie: nil, welcome: nil, turn_message: nil , print_board: nil, end_game: nil ) }
  let(:setup) { Challenge::Setup.new(ui) }
  let(:human) { double("human", marker: 'X', move: 3) }
  let(:ai) { double("ai", marker: 'O', move: 5) }
  let(:game) { Challenge::Game.new(board, human, ai, ui) }

  describe "starting the game" do
    it "prints the welcome message, asks for players markers and order" do
      expect(ui).to receive(:welcome)
      allow(ui).to receive(:get_player_marks).and_return( "X, O" )
      allow(ui).to receive(:get_player_order).and_return( 0, 1 )
      setup.run
    end

    it "calls the print board function" do
      expect(ui).to receive(:print_board)
      allow(board).to receive(:over?).and_return(true)
      game.start_game
    end
  end

  describe "displaying a winner" do
    it "shows a win if the game was won" do
      allow(board).to receive(:over?).and_return(false)
      allow(board).to receive(:win?).and_return(true)

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

  # it shows a tie if the game is a tie
  describe "displaying a tie" do
    it "shows a tie message" do
      expect(ui).to receive(:tie)
      expect(ui).to receive(:end_game)

      allow(board).to receive(:over?).and_return(false)
      allow(board).to receive(:tie?).and_return(true)

      game.start_game
    end
  end

  describe "changes the players for the next move" do
    it "displays a message with new player marker" do
      allow(board).to receive(:over?).and_return(false, false, true)
      expect(ui).to receive(:turn_message).with(ai)
      game.start_game
    end
  end

  describe "a player turn" do
    it "get the player next move" do
      allow(board).to receive(:over?).and_return(false, false, true)
      expect(human).to receive(:move)
      game.start_game
    end

    it "display a message for invalid move" do
      allow(board).to receive(:over?).and_return(false, true)
      expect(board).to receive(:is_available?).and_return(false)
      expect(ui).to receive(:position_inavailable).with(3)
      game.start_game
    end
  end
end
