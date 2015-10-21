require_relative 'Board'
require_relative 'console'
require_relative 'player'

module Challenge

  module PlayerFactory

  end
  class Game
    attr_reader :board, :ui, :player1, :player2
    def initialize(board, player_1, player_2, ui)
      @board = board
      @ui = ui
      @player1 = player_1
      @player2 = player_2
    end

    def start_game
      print_board

      player, opponent = @player1, @player2

      while true
        #print player turn
        ui.turn_message(player)

        #get player choice
        player.move!(board)

        #show the last move
        print_board

        #check if the game ended
        if board.winner
          ui.win(player)
          ui.end_game
          break
        end

        if board.tie?
          ui.tie
          ui.end_game
          break
        end

        player, opponent = opponent, player
      end
    end

    def print_board
      ui.print_board(board)
    end
  end
end
