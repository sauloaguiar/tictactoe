require_relative 'Board'
require_relative 'ui'
require_relative 'console'
require_relative 'player'

module Challenge
  class Game
    attr_reader :board, :ui, :player1, :player2
    def initialize
      @board = Board.new
      @ui = UI.new
    end

    def create_players
      p1, p2 = ui.get_player_marks

      current = HumanPlayer.new(p1, ui)
      testers = PCPlayer.new(p2, ui)

      @player1, @player2 = ui.get_player_order(current, testers)
    end

    def start_game
      ui.welcome

      create_players

      print_board

      player, opponent = player1, player2

      while true
        #print player turn
        ui.turn_message(player)

        #get player choice
        player.move!(board)

        #show where he's played
        print_board

        #check if the game ended
        if board.game_is_over || board.tie
          ui.tie
          ui.end_game
          break
        end

        if board.winner
          ui.winner(player)
          ui.end_game
          break
        end

        player, opponent = opponent, player
      end
    end

    def change_players!
      player, opponent = opponent, player
    end

    def print_board
      ui.print_board(board)
    end

    def get_human_spot
      spot = nil
      until spot
        spot = gets.chomp.to_i
        if board.cells[spot] != "X" && board.cells[spot] != "O"
          board.cells[spot] = @hum
        else
          spot = nil
        end
      end
    end
  end
end