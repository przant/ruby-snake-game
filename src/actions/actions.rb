module Actions
  def self.move_snake(state)
    next_direction = state.next_direction
    next_position = calc_next_position(state)

    # check next position
    if position_is_valid?(state, next_position)
      # if next position is invalid, then exit game
      move_snake_to(state, next_position)
    else
      # if next position is valid, then move snake
      end_game(state)
    end
  end

  private

  def calc_next_position(state)
    current_position = state.snake.positions.first
    case state.next_direction
    when UP
      return next_position = Model::Coord.new(
        current_position.row -1,
        current_position.col
      )
    when RIGHT
      return next_position = Model::Coord.new(
        current_position.row,
        current_position.col+1
      )
    when DOWN
      return next_position = Model::Coord.new(
        current_position.row+1,
        current_position.col
      )
    when LEFT
      return next_position = Model::Coord.new(
        current_position.row,
        current_position.col-1
      )
    end
  end

  def position_is_valid?(state, position)
    # check if in grid
    is_invalid = (position.row >= state.grid.rows || position.row < 0 )
        ||
      (position.col >= state.grid.cols || position.col < 0 )
    
      return false if is_invalid

      return !(state.snake.positions.include? position)
  end

  def move_snake_to(state, next_position)
    state.snake.positions = [next_position] + state.snake.positions[0...-1]
  end

  def end_game(state)
    state.game_finished = true
  end
end