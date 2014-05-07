# app/models/board.rb
class Board
  attr_accessor :board_cells, :size

  def initialize(cells)
    @size         = Math.sqrt(cells.size).to_i
    @board_cells  = Array.new(size) { Array.new(size) }
    process_current_board_state(cells)
  end

  def winning_move_for?(piece)
    winning_row?(piece) or
    winning_column?(piece) or
    winning_diagonal?(piece) or
    winning_reverse_diagonal?(piece)
  end

  def blank_cells
    moves = []
    cell_indexes do |row, column|
      moves.push([row, column]) if board_cells[row][column].nil?
    end
    moves
  end

  def blank_board?
    blank_cells.count == size**2
  end

  def cell_indexes
    board_cells.each_index do |row|
      board_cells[row].each_index do |column|
        yield row, column
      end
    end
  end

  private
  def process_current_board_state(cells)
    cells.each do |cell|
      board_cells[cell["row"]][cell["col"]] = cell["value"] if cell["value"]
    end
  end

  def winning_row?(piece)
    board_cells.each{|row| return true if row.count(piece) == size }
    false
  end

  def winning_column?(piece)
    board_cells.transpose.each{|row| return true if row.count(piece) == size }
    false
  end

  def winning_diagonal?(piece)
    board_cells.each_with_index{|row, index| return false unless row[index] == piece }
    true
  end

  def winning_reverse_diagonal?(piece)
    board_cells.each_with_index{|row, index| return false unless row[size - index - 1] == piece }
    true
  end
end
