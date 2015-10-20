require 'set'

module Challenge
  class Board
    attr_accessor :cells, :size

    def initialize(size = 3)
      @size = size
      @cells = Array[]
      for index in 0..((size*size)-1) do
        @cells.push(index.to_s)
      end
    end

    # if we don't have any more space left
    #def game_is_over
    #  [cells[0], cells[1], cells[2]].uniq.length == 1 ||
    #  [cells[3], cells[4], cells[5]].uniq.length == 1 ||
    #  [cells[6], cells[7], cells[8]].uniq.length == 1 ||
    #  [cells[0], cells[3], cells[6]].uniq.length == 1 ||
    #  [cells[1], cells[4], cells[7]].uniq.length == 1 ||
    #  [cells[2], cells[5], cells[8]].uniq.length == 1 ||
    #  [cells[0], cells[4], cells[8]].uniq.length == 1 ||
    #  [cells[2], cells[4], cells[6]].uniq.length == 1
    #end

    # if all cells where either char of one player or from another
    def tie?
      @cells.all? { |s| s == "X" || s == "O" }
    end

    # for every victory possibility, checks if it holds for the given marker
    def victory_entry(marker)
      x_cells = cells.each_index.select{|i| cells[i] ==  marker}

      x_cells_set = x_cells.to_set
      get_victory_entries.each do |entry|
        puts entry
        puts "\n"
        entry_set = entry.to_set
        if (entry_set.subset? x_cells_set)
          return x_cells
        end
      end

      false
    end

    # gets the first line representing a victory for the specific marker
    def victory_line
      entry = victory_entry("X")
      entry ? entry : victory_entry("O")
    end

    def get_victory_entries()
      entries = Array[]
      entries.push(get_victory_rows)
      entries.push(get_victory_cols)
      entries.push(get_victory_diagonals)
      entries.flatten(1)
    end


    #0 1 2     0  1  2  3     0  1  2  3  4    0  1  2  3  4  5
    #3 4 5     4  5  6  7     5  6  7  8  9    6  7  8  9 10 11
    #6 7 8     8  9 10 11    10 11 12 13 14   12 13 14 15 16 17
    #         12 13 14 15    15 16 17 18 19   18 19 20 21 22 23
    # =>                     20 21 22 23 24   24 25 26 27 28 29
    # =>                                      30 31 32 33 34 35
      # 8 7 6 5 4 3 2 1 0

    # 0 4 8

    # 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15

    # 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24

    def get_victory_rows()
      result = Array[]
      for row in 0..@size-1 do
        current = Array[]
        for col in 0..@size-1 do
            current.push((row * @size) + col)
        end
        result.push(current)
      end
      result
    end

    def get_victory_cols()
      get_victory_rows.transpose
    end

    def get_victory_diagonals()
      array = @cells.map { |x| x.to_i }
      elem = Array[]
      diag1 = Array[]
      while array.size() >= 1 do
        diag1.push(array[0])
        array = array.drop(@size+1)
      end
      elem.push(diag1)
      diag2 = Array[]
      for i in 1..@size do
        diag2.push(i * (@size-1))
      end
      elem.push(diag2)
    end

    # if we got an victory_line in our board, let's get who has won
    def winner
      entry = victory_line
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
