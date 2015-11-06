require_relative 'Board'
require_relative 'console'
require_relative 'player'

module Challenge

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

      while over?
        #print player turn
        ui.turn_message(player)

        #get player choice
        next_move(player)

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

    def next_move(player)
      spot = player.move(board)
      until board.is_available?(spot)
        ui.position_inavailable
        spot = player.move(board)
      end
      board.fill_position!(spot, player.marker)
    end

    def over?
      !board.winner || board.tie?
    end

    def print_board
      ui.print_board(board)
    end
  end
end
