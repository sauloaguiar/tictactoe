module Challenge
  class Player
    attr_reader :marker, :ui
    def initialize(marker, ui)
      @marker = marker
      @ui = ui
    end

    def move(board)
      raise "Not implemented"
    end

    def getOpponentMarker
      return "X" == marker ? "O" : "X"
    end
  end

  class HumanPlayer < Player
    def move(board)
      ui.human_move
    end

    def to_s
      "Human (#{marker})"
    end
  end

  class PCPlayer < Player
    def initialize(marker, ui)
      super(marker, ui)
      @opponent = getOpponentMarker
    end

    def move(board)
      ui.pc_move
      sleep(2)
      eval_board(board)
    end

    def eval_board(board)
      spot = nil
      until spot
        if board.cells[4] == "4"
          spot = 4
          #board.cells[spot] = marker
        else
          spot = get_best_move(board, marker)
          #if board.cells[spot] != "X" && board.cells[spot] != "O"
            #board.cells[spot] = marker
          #else
          # spot = nil
          #end
        end
      end
      p spot
      spot
    end

    def get_best_move(board, next_player, depth = 0, best_score = {})
      available_spaces = []
      best_move = nil
      board.cells.each do |s|
        if s != "X" && s != "O"
          available_spaces << s
        end
      end
      available_spaces.each do |as|
        board.cells[as.to_i] = marker
        if board.tie?
          best_move = as.to_i
          board.cells[as.to_i] = as
          return best_move
        else
          board.cells[as.to_i] = @opponent
          if board.tie?
            best_move = as.to_i
            board.cells[as.to_i] = as
            return best_move
          else
            board.cells[as.to_i] = as
          end
        end
      end
      if best_move
        return best_move
      else
        n = rand(0..available_spaces.count)
        return available_spaces[n].to_i
      end
    end

    def to_s
      "PC (#{marker})"
    end
  end
end
