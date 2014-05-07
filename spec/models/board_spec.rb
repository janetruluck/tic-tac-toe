# spec/models/board_spec.rb
require "spec_helper"

describe Board do 
  describe ".new" do
    let(:board) { Board.new(blank_board) }

    it "loads the cells into board_cells" do
      expect(board.board_cells.flatten.count).to eq(9)
    end

    it "sets the size of the board" do
      expect(board.size).to eq(3)
    end
  end

  describe ".blank_cells" do
    context "blank board" do
      let(:board) { Board.new(blank_board) }

      it "returns all cells" do
        expect(board.blank_cells.count).to eq(9)
      end
    end

    context "3 cells taken" do
      let(:board) { Board.new(winning_row) }

      it "returns the remaining 6 cells" do
        expect(board.blank_cells.count).to eq(6)
      end
    end
  end

  context "non winning board" do
    let(:board) { Board.new(blank_board) }

    describe ".winning_move_for?" do
      it { expect(board.winning_move_for?("x")).to eq(false) }
    end
  end

  context "winning row" do
    let(:board) { Board.new(winning_row) }

    describe ".winning_move_for?" do
      it { expect(board.winning_move_for?("x")).to eq(true) }
    end
  end

  context "winning col" do
    let(:board) { Board.new(winning_col) }

    describe ".winning_move_for?" do
      it { expect(board.winning_move_for?("x")).to eq(true) }
    end
  end

  context "winning diagonal" do
    let(:board) { Board.new(winning_diag) }

    describe ".winning_move_for?" do
      it { expect(board.winning_move_for?("x")).to eq(true) }
    end
  end

  context "winning reverse diagonal" do
    let(:board) { Board.new(winning_rdiag) }

    describe ".winning_move_for?" do
      it { expect(board.winning_move_for?("x")).to eq(true) }
    end
  end
end