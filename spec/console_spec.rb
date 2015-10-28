require 'spec_helper'
require 'stringio'

describe Challenge::ConsoleUI do

  let(:input) { StringIO.new }
  let(:output) { StringIO.new }
  let(:console) { Challenge::ConsoleUI.new(input, output) }

  describe "#print_board" do
    context "board size 3" do
      it "should print the board as expected" do
        console.welcome
        expect(console.output.string).to eq("Welcome to my Tic Tac Toe game\n")
      end
    end
  end
end
