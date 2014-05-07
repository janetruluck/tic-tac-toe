class Game
  attr_reader :board, :ai, :player_piece, :opponent_piece

  def initialize(cells, player_piece)
    @player_piece   = player_piece
    @opponent_piece = player_piece == 'x' ? 'o' : 'x'
    @board          = Board.new(cells)
    @ai             = Ai.new(player_piece)
  end

  def perfect_move
    if board.blank_board?
      { "winner" => winner, "draw" => draw?, "move" => random_move}
    else
      if draw?
        { "winner" => nil, "draw" => draw?, "move" => nil }
      else
        move   = ai.generate_move_for_game(self)
        result = next_game_state([move["row"], move["col"]])
        { "winner" => result.winner, "draw" => result.draw?, "move" => move }
      end
    end
  end

  def next_game_state(choice)
    new_cells = Array.new

    board.cell_indexes do |row, col|
      matching_piece = (row == choice[0] && col == choice[1])
      piece = matching_piece ? player_piece : board.board_cells[row][col]
      new_cells.push({ "row" => row, "col" => col, "value" => piece })
    end

    Game.new(new_cells, opponent_piece)
  end

  def complete?
    winner? or draw?
  end

  def winner
    return player_piece   if victory?(player_piece)
    return opponent_piece if victory?(opponent_piece)
  end

  def winner?
    victory?(player_piece) or
    victory?(opponent_piece)
  end

  def draw?
    !winner? && !board.board_cells.flatten.include?(nil)
  end

  def victory?(piece)
    board.winning_move_for?(piece)
  end

  def defeat?(piece)
    !draw? && !board.winning_move_for?(piece)
  end

  private
  def random_move
    { 
      "row" => rand(board.size), 
      "col" => rand(board.size), 
      "value" => player_piece 
    }
  end
end
