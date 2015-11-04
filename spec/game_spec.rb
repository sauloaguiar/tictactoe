require_relative 'spec_helper'

require_relative '../lib/player'
require_relative '../lib/board'
require_relative '../lib/console'
require_relative '../lib/setup'

describe Challenge::Game do

  let(:board) { double( "board", winner: nil, tie?: false) }
  let(:ui) { double("ui", tie: nil, welcome: nil, turn_message: nil , print_board: nil) }
  let(:setup) { double("setup", ui: nil) }
  let(:human) { double("human", marker: 'X', move: 3) }
  let(:ai) { double("ai", marker: 'O', move: 5) }
  let(:game) { Challenge::Game.new(board, human, ai, ui) }

  describe "starting the game" do
    it "calls the print board function" do
      expect(ui).to receive(:print_board)
      allow(board).to receive(:tie?) { true }
      game.start_game
    end
  end

end
