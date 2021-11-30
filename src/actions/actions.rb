require_relative '../model/state'

module Actions
  def self.move_snake(state)
    next_direction = state.next_direction
    next_position = calc_next_position(state)

    # check next position
    if position_is_valid?(state, next_position)
      # if next position is valid, then move snake
      move_snake_to(state, next_position)
    else
      # if next position is invalid, then exit game
      end_game(state)
    end
  end

  private

  def self.calc_next_position(state)
    current_position = state.snake.positions.first
    case state.next_direction
    when Model::Direction::UP
      return next_position = Model::Coord.new(
        current_position.row-1,
        current_position.col
      )
    when Model::Direction::RIGHT
      return next_position = Model::Coord.new(
        current_position.row,
        current_position.col+1
      )
    when Model::Direction::DOWN
      return next_position = Model::Coord.new(
        current_position.row+1,
        current_position.col
      )
    when Model::Direction::LEFT
      return next_position = Model::Coord.new(
        current_position.row,
        current_position.col-1
      )
    end
  end

  def self.position_is_valid?(state, position)
    # check if in grid
    is_invalid = (position.row >= state.grid.rows || position.row < 0 ) ||
      (position.col >= state.grid.cols || position.col < 0 )
    
      return false if is_invalid

      return !(state.snake.positions.include? position)
  end

  def self.move_snake_to(state, next_position)
    state.snake.positions = [next_position] + state.snake.positions[0...-1]
    state
  end

  def self.end_game(state)
    state.game_finished = true
    state
  end
end