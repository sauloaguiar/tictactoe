require_relative 'Board'
require_relative 'console'
require_relative 'player'

module Challenge
  class Setup

    attr_reader :ui, :board, :player1, :player2

    def initialize(ui)
      @ui = ui
    end

    def run
      @ui.welcome
      @player1, @player2 = setup_players
      @board = Challenge::Board.new
    end

    def setup_players
      p1, p2 = @ui.get_player_marks

      current = HumanPlayer.new(p1, @ui)
      testers = PCPlayer.new(p2, @ui)

      @ui.get_player_order(current, testers)
    end

  end
end
