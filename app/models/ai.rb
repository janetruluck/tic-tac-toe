class Ai
  attr_reader :piece, :calculated_move

  def initialize(piece)
    @piece = piece
  end

  # Returns the best calculated move
  def generate_move_for_game(game)
    calculate_move(game, 0)
    { 
      "row"   => calculated_move[0], 
      "col"   => calculated_move[1], 
      "value" => piece
    }
  end

  private
  # Implement the minimax algorithim to calculate the best next move
  def calculate_move(game, depth)
    return cell_score(game, depth) if game.complete?

    scores = Array.new
    moves  = Array.new

    game.board.blank_cells.each do |cell|
      scores.push(calculate_move(game.next_game_state(cell), depth + 1))
      moves.push(cell)
    end

    game.player_piece == piece ? max(scores, moves) : min(scores, moves)
  end

  def max(scores, moves)
    index = scores.index(scores.max)
    @calculated_move = moves[index]
    return scores[index]
  end

  def min(scores, moves)
    index = scores.index(scores.min)
    @calculated_move = moves[index]
    return scores[index]
  end

  def cell_score(game, depth)
    if game.victory?(piece)
      10 - depth
    elsif game.defeat?(piece)
      depth - 10
    else
      0
    end
  end
end