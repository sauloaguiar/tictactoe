module Challenge
  class Console
    def print_board(board)
      line = "|_"
      for i in 0..board.size*board.size-1 do
        line += "#{board.cells[i]}_|_"
        if ((i+1) % board.size == 0)
          line += "\n|_"
        end

        #line += "#{board.cells[i+board.size-1]}_|\n"
      end
      puts line + "\n"
      #puts "|_#{board.cells[0]}_|_#{board.cells[1]}_|_#{board.cells[2]}_|\n|_#{board.cells[3]}_|_#{board.cells[4]}_|_#{board.cells[5]}_|\n|_#{board.cells[6]}_|_#{board.cells[7]}_|_#{board.cells[8]}_|\n\n"
    end

    # def print_board(board)
    #   output = ""
    #   size = board.size*board.size - 1
    #   0.upto(9) do |position|
    #     output << " #{board.cells[position] || position} "
    #     case position % 3
    #       when 0,1 then output << "|"
    #       when 2 then output << "\n----------\n" unless position == 8
    #     end
    #   end
    #   puts output
    # end

    def welcome
      puts "Welcome to my Tic Tac Toe game"
    end

    def turn_message(player)
      puts "#{player} turn!"
    end

    def end_game
      puts "Game over"
    end

    def game_is_over
      puts "No more spots left!"
    end

    def get_player_marks
      regex = "/(X|O)/"
      puts "Enter human's player mark(X or O): "
      while true do
        first = gets.chomp
        case first
        when "X"
          second = "O"
          break
        when "O"
          second = "X"
          break
        else
          puts "#{first} is not a valid option!"
          puts "Enter first player's mark(X or O): "
        end
      end
      puts "PC will play with #{second}"
      return first, second
    end

    def get_player_order(player1, player2)
      puts "Who will play first? Put 1 for: #{player1} or 2 for: #{player2}"
      while true do
        input = gets.chomp.to_i
        case input
          when 1
            return player1, player2
          when 2
            return player2, player1
          else
            puts "#{input} is not a valid input!"
            puts "Who will play first? Put 1 for: #{player1} or 2 for: #{player2}"
        end
      end
    end

    def player_move
      puts "Where to move?"
      while true do
        pos = gets.chomp.to_i
        case pos
        when 0 .. 8
          return pos
        else
          puts "#{pos} is not a valid spot!"
        end
      end
    end

    def pc_move
      puts "PC choosing..."
    end

    def win(player)
      puts "#{player} has won!"
    end

    def tie
      puts "It was a tie!"
    end

    def position_inavailable
      puts "Position not available. Try again!"
    end
  end
end
