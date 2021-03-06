module Challenge
  class ConsoleUI

    attr_reader :output

    def initialize(input = $stdin, output = $stdout)
      @output = output
      @input = input
    end

    def print_board(board)
      output = ""
      separator = "-----" * board.size
      number_of_pieces = board.size*board.size - 1
      0.upto(number_of_pieces) do |position|
        output << " #{board.cells[position]} "
        case position % board.size
        when 0..board.size-2 then (output << "| ")
        when board.size-1 then (output << "\n" + separator + "\n") unless position == number_of_pieces
        end
      end
      @output.puts output
    end

    def welcome
      @output.puts "Welcome to my Tic Tac Toe game"
    end

    def turn_message(player)
      @output.puts "#{player} turn!"
    end

    def end_game
      @output.puts "Game Over!"
    end

    def get_player_marks
      regex = "/(X|O)/"
      @output.puts "Enter human's player mark(X or O): "
      while true do
        first = @input.gets.chomp
        case first
        when "X"
          second = "O"
          break
        when "O"
          second = "X"
          break
        else
          @output.puts "#{first} is not a valid option!"
          @output.puts "Enter first player's mark(X or O): "
        end
      end
      @output.puts "PC will play with #{second}"
      return first, second
    end

    def get_player_order(player1, player2)
      @output.puts "Who will play first? Put 1 for: #{player1} or 2 for: #{player2}"
      while true do
        ins = @input.gets.chomp.to_i
        case ins
          when 1
            return player1, player2
          when 2
            return player2, player1
          else
            @output.puts "#{ins} is not a valid input!"
            @output.puts "Who will play first? Put 1 for: #{player1} or 2 for: #{player2}"
        end
      end
    end

    def human_move
      @output.puts "Where to move?"
      while position = @input.gets.chomp do
        break if /^\d+$/.match(position)
        #@output.puts "#{position} is not a valid spot!"
        position_inavailable(position)
      end
      position.to_i
    end

    def pc_move
      @output.puts "PC choosing..."
    end

    def win(player)
      @output.puts "#{player} has won!"
    end

    def tie
      @output.puts "It was a tie!"
    end

    def position_inavailable(position)
      @output.puts "Position #{position} not available. Try again!"
    end
  end
end
