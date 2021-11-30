require_relative '../model/state'

module Actions
  def self.move_snake(state)
    next_direction = state.current_direction
    next_position = calc_next_position(state)
    if position_is_food?(state, next_position)
      state = grow_snake_to(state, next_position)
      generate_food(state)
    # check next position
    elsif position_is_valid?(state, next_position)
      # if next position is valid, then move snake
      move_snake_to(state, next_position)
    else
      # if next position is invalid, then exit game
      end_game(state)
    end
  end

  def self.change_direction(state, direction)
    if next_direction_is_valid?(state, direction)
      state.current_direction = direction
    else
      puts "invalid direction"
    end
    state
  end

  private

  def self.generate_food(state)
    state
  end

  def self.position_is_food?(state, next_position)
    state.food.row == next_position.row && state.food.col == next_position.col
  end

  def self.grow_snake_to(state, next_position)
    new_positions = [next_position] + state.snake.positions
    state.snake.positions = new_positions
    state
  end

  def self.calc_next_position(state)
    current_position = state.snake.positions.first
    case state.current_direction
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

  def self.next_direction_is_valid?(state, direction)
    case state.current_direction
    when Model::Direction::UP
      return true if direction != Model::Direction::DOWN
    when Model::Direction::DOWN
      return true if direction != Model::Direction::UP
    when Model::Direction::LEFT
      return true if direction != Model::Direction::RIGHT
    when Model::Direction::RIGHT
      return true if direction != Model::Direction::LEFT
    end

    return false
  end
end