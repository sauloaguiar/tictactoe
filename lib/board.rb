module Challenge
  class Board
    attr_accessor :cells
    # 0 1 2
    # 3 4 5
    # 6 7 8
    VICTORY = [
        # lines:
        [0, 1, 2], [3, 4, 5], [6, 7, 8],
        # columns:
        [0, 3, 6], [1, 4, 7], [2, 5, 8],
        # diagonals:
        [0, 4, 8], [2, 4, 6]
      ]

    def initialize
      @cells = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    end

    # if we don't have any more space left
    def game_is_over
      [cells[0], cells[1], cells[2]].uniq.length == 1 ||
      [cells[3], cells[4], cells[5]].uniq.length == 1 ||
      [cells[6], cells[7], cells[8]].uniq.length == 1 ||
      [cells[0], cells[3], cells[6]].uniq.length == 1 ||
      [cells[1], cells[4], cells[7]].uniq.length == 1 ||
      [cells[2], cells[5], cells[8]].uniq.length == 1 ||
      [cells[0], cells[4], cells[8]].uniq.length == 1 ||
      [cells[2], cells[4], cells[6]].uniq.length == 1
    end

    # if all cells where either char of one player or from another
    def tie
      cells.all? { |s| s == "X" || s == "O" }
    end

    # for every victory possibility, checks if it holds
    def victoryEntry
      VICTORY.each do |entry|
        if cells[entry[0]] == cells[entry[1]] and cells[entry[1]] == cells[entry[2]]
          return entry
        end
      end
      false
    end

    # if we got an victory_line in our board, let's get who has won
    def winner
      entry = victoryEntry
      entry ? cells[entry[0]] : false
    end

    def validate(position)
      return !(cells[position] == "X" || cells[position] == "O")
    end

    def fill_position!(position, marker)
      if validate(position)
        cells[position] = marker
      end
    end
  end
end
