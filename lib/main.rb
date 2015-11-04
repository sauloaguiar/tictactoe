require_relative 'game'
require_relative 'setup'
require_relative 'console'

ui = Challenge::ConsoleUI.new($stdin, $stdout)
setup = Challenge::Setup.new(ui)
setup.run
game = Challenge::Game.new(setup.board, setup.player1, setup.player2, ui)
game.start_game
