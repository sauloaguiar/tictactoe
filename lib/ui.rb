module Challenge
  class UI
    attr_reader :interface
    def initialize(argument = Console.new)
      @interface = argument
    end

    def print_board(board)
      interface.print_board(board)
    end

    def welcome
      interface.welcome
    end

    def turn_message(player)
      interface.turn_message(player)
    end

    def end_game
      interface.end_game
    end

    def get_player_marks
      return interface.get_player_marks
    end

    def get_player_order(player1, player2)
      return interface.get_player_order(player1, player2)
    end

    def player_move
      return interface.player_move
    end

    def pc_move
      interface.pc_move
    end

    def win(player)
      interface.win(player)
    end

    def tie
      interface.tie
    end

    def position_inavailable
      interface.position_inavailable
    end
  end
end
