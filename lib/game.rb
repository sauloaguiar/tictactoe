require_relative 'Board'
require_relative 'console'
require_relative 'player'

module Challenge

  class Game
    attr_reader :board, :ui, :players
    def initialize(board, player_1, player_2, ui)
      @board = board
      @ui = ui
      @players = [player_1, player_2]
      @turn = 0
    end

    def current_player
      @players[@turn]
    end

    def change_players
      @turn == 1 ? @turn = 0 : @turn = 1
    end

    def start_game
      print_board

      while !over?
        #print player turn
        ui.turn_message(current_player)

        #get player choice
        next_move(current_player)

        #show the last move
        print_board

        #check if the game ended
        if board.win?
          ui.win(current_player)
          ui.end_game
          break
        end

        if board.tie?
          ui.tie
          ui.end_game
          break
        end

        change_players
      end
    end

    def next_move(player)
      spot = player.move(board)
      until board.is_available?(spot)
        ui.position_inavailable(spot)
        spot = player.move(board)
      end
      board.fill_position!(spot, player.marker)
    end

    def over?
      board.over?
    end

    def print_board
      ui.print_board(board)
    end
  end
end
