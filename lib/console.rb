module Challenge
  class Console
    def print_board(board)
      puts "|_#{board.cells[0]}_|_#{board.cells[1]}_|_#{board.cells[2]}_|\n|_#{board.cells[3]}_|_#{board.cells[4]}_|_#{board.cells[5]}_|\n|_#{board.cells[6]}_|_#{board.cells[7]}_|_#{board.cells[8]}_|\n\n"
    end

    def welcome
      puts "Welcome to my Tic Tac Toe game"
    end

    def turn_message(player)
      puts "#{player} turn!"
    end

    def end_game
      puts "Game over"
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

    def win(player)
      puts "#{player} has won!"
    end

    def tie
      puts "It was a tie!"
    end
  end
end
