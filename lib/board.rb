require 'set'

module Challenge
  class Board
    attr_accessor :cells, :size

    def initialize(size = 3)
      @size = size
      @cells = Array.new(@size * @size) { |i| i.to_s }
    end

    def highest_index
      @size * @size - 1
    end

    # if all cells where either char of one player or from another
    def tie?
      @cells.all? { |s| s == "X" || s == "O" }
    end

    # for every victory possibility, checks if it holds for the given marker
    def victory_entry(marker)
      x_cells = cells.each_index.select { |i| cells[i] ==  marker }
      x_cells_set = x_cells.to_set
      get_victory_entries.each do |entry|
        entry_set = entry.to_set
        if (entry_set.subset? x_cells_set)
          return x_cells
        end
      end

      false
    end

    # gets the first line representing a victory for the specific marker
    def victory_line
      victory_entry("X") || victory_entry("O")
    end

    def get_victory_entries()
      entries = []
      entries.push(get_victory_rows)
      entries.push(get_victory_cols)
      entries.push(get_victory_diagonals)
      entries.flatten(1)
    end

    def get_victory_rows
      result = []
      for row in 0..@size-1 do
        current = []
        for col in 0..@size-1 do
            current.push((row * @size) + col)
        end
        result.push(current)
      end
      result
    end

    def get_victory_cols
      rows = get_victory_rows
      cols = rows.transpose
      return cols
    end

    def get_victory_diagonals
      array = @cells.map { |x| x.to_i }
      elem = []
      diag1 = []
      for i in 0..size-1 do
        diag1.push(i * (size+1))
      end
      elem.push(diag1)
      diag2 = []
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

    def is_available?(position)
      return !(cells[position] == "X" || cells[position] == "O")
    end

    def fill_position!(position, marker)
      if is_available?(position)
        cells[position] = marker
      end
    end
  end
end
