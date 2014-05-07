require 'spec_helper'

describe Ai do
  describe ".new" do
    let(:ai) { Ai.new("x") }

    it "sets the piece" do
      expect(ai.piece).to eq("x")
    end
  end

  describe ".generate_move_for_game" do
    context "blank board" do
      let(:game) { Game.new(blank_board, "o") }
      let(:ai)   { game.ai }

      it "places the piece at 0,0" do
        expect(ai.generate_move_for_game(game)).to eq({
          "row"  => 0, 
          "col"  => 0, 
          "value"=> "o"
        })
      end
    end

    context "player first move @ 0,0" do
      let(:game) { Game.new(player_first_move, "o") }
      let(:ai)   { game.ai }

      it "places the piece at 1,1" do
        expect(ai.generate_move_for_game(game)).to eq({
          "row"  => 1, 
          "col"  => 1, 
          "value"=> "o"
        })
      end
    end

    context "potential player win" do
      let(:game) { Game.new(potential_player_win, "o") }
      let(:ai)   { game.ai }

      it "blocks the win" do
        expect(ai.generate_move_for_game(game)).to eq({
          "row"  => 0, 
          "col"  => 2, 
          "value"=> "o"
        })
      end
    end

    context "potential ai win" do
      let(:game) { Game.new(potential_ai_win, "o") }
      let(:ai)   { game.ai }

      it "takes the win" do
        expect(ai.generate_move_for_game(game)).to eq({
          "row"  => 1, 
          "col"  => 2, 
          "value"=> "o"
        })
      end
    end
  end
end

