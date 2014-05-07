require 'spec_helper'

describe Game do
  describe ".new" do
    let(:game) { Game.new(blank_board, "x") }

    it "sets the player_piece" do
      expect(game.player_piece).to eq("x")
    end

    it "sets the opponent_piece" do
      expect(game.opponent_piece).to eq("o")
    end

    it "sets the board" do
      expect(game.board).to_not be_nil
    end

    it "sets the ai" do
      expect(game.ai).to_not be_nil
    end
  end

  describe ".perfect_move" do
    let(:game) { Game.new(player_first_move, "x") }

    it "returns the next move" do
      expect(game.perfect_move).to eq({
        "winner" => nil, 
        "draw"   => false, 
        "move"   => {"row"=>0, "col"=>1, "value"=>"x"}
      })
    end

    context 'draw' do
      let(:game) { Game.new(draw_board, "x") }

      it "returns the next move" do
        expect(game.perfect_move).to eq({
          "winner" => nil, 
          "draw"   => true, 
          "move"   => nil
        })
      end
    end

    context 'win' do
      let(:game) { Game.new(potential_ai_win, "x") }

      it "returns the next move" do
        expect(game.perfect_move).to eq({
          "winner" => "x", 
          "draw"   => false, 
          "move"   => {"row"=>0, "col"=>2, "value"=>"x"}
        })
      end
    end
  end

  describe ".winner" do
    context "blank board" do
      let(:game) { Game.new(blank_board, "x") }

      it { expect(game.winner).to eq(nil) }
    end

    context "win" do
      let(:game) { Game.new(winning_col, "x") }

      it { expect(game.winner).to eq("x") }
    end
  end

  describe ".winner?" do
    context "blank board" do
      let(:game) { Game.new(player_first_move, "x") }

      it { expect(game.winner?).to eq(false) }
    end

    context "win" do
      let(:game) { Game.new(winning_col, "x") }

      it { expect(game.winner?).to eq(true) }
    end
  end

  describe ".draw?" do
    context "blank board" do
      let(:game) { Game.new(player_first_move, "x") }

      it { expect(game.draw?).to eq(false) }
    end

    context "draw" do
      let(:game) { Game.new(draw_board, "x") }

      it { expect(game.draw?).to eq(true) }
    end
  end

  describe ".victory?" do
    context "blank board" do
      let(:game) { Game.new(player_first_move, "x") }

      it { expect(game.victory?("x")).to eq(false) }
    end

    context "win" do
      let(:game) { Game.new(winning_col, "x") }

      it { expect(game.victory?("x")).to eq(true) }
    end

    context "no win" do
      let(:game) { Game.new(winning_col, "x") }

      it { expect(game.victory?("o")).to eq(false) }
    end
  end

  describe ".defeat?" do
    context "win" do
      let(:game) { Game.new(winning_col, "x") }

      it { expect(game.defeat?("x")).to eq(false) }
    end

    context "no win" do
      let(:game) { Game.new(winning_col, "x") }

      it { expect(game.defeat?("o")).to eq(true) }
    end
  end
end

