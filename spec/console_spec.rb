require 'spec_helper'
require 'stringio'
require_relative '../lib/player'

describe Challenge::ConsoleUI do

  let(:input) { StringIO.new }
  let(:output) { StringIO.new }
  let(:console) { Challenge::ConsoleUI.new(input, output) }

  describe "#welcome" do
    context "StringIO as dependency" do
      it "should print the welcome message as expected" do
        console.welcome
        expect(console.output.string).to eq("Welcome to my Tic Tac Toe game\n")
      end
    end
  end

  describe "#turn_message" do
    context "human player's turn" do
      it "should print X as marker" do
        human = Challenge::HumanPlayer.new("X", console)
        console.turn_message(human)
        expect(console.output.string).to eq("Human (X) turn!\n")
      end
      it "should print O as marker" do
        human = Challenge::HumanPlayer.new("O", console)
        console.turn_message(human)
        expect(console.output.string).to eq("Human (O) turn!\n")
      end
    end

    context "pc player's turn" do
      it "should print X as marker" do
        pc = Challenge::PCPlayer.new("X", console)
        console.turn_message(pc)
        expect(console.output.string).to eq("PC (X) turn!\n")
      end
      it "should print O as marker" do
        pc = Challenge::PCPlayer.new("O", console)
        console.turn_message(pc)
        expect(console.output.string).to eq("PC (O) turn!\n")
      end
    end
  end

  describe "#end_game" do
    context "StringIO as dependency" do
        it "should print game ending message" do
          console.end_game
          expect(console.output.string).to eq("Game Over!\n")
        end
    end
  end

  describe "#win" do
    context "PC player as winner" do
      it "should print the X marker" do
        pc = Challenge::PCPlayer.new("X", console)
        console.win(pc)
        expect(console.output.string).to eq("PC (X) has won!\n")
      end
      it "should print the X marker" do
        pc = Challenge::PCPlayer.new("O", console)
        console.win(pc)
        expect(console.output.string).to eq("PC (O) has won!\n")
      end
    end

    context "Human player as winner" do
      it "should print the X marker" do
        human = Challenge::HumanPlayer.new("X", console)
        console.win(human)
        expect(console.output.string).to eq("Human (X) has won!\n")
      end

      it "should print the O marker" do
        human = Challenge::HumanPlayer.new("O", console)
        console.win(human)
        expect(console.output.string).to eq("Human (O) has won!\n")
      end
    end
  end
end
