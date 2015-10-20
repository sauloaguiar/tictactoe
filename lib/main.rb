require_relative 'game'

game = Challenge::Game.new(Challenge::Board.new, Challenge::UI.new)
game.start_game
