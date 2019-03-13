class Position
  attr_reader :rel_x, :rel_y

  def initialize(
    step_x:,
    step_y: step_x,
    left_limit:,
    right_limit:,
    bottom_limit:,
    top_limit:
  )
    @rel_x = 0
    @rel_y = 0
    @left_limit = left_limit
    @right_limit = right_limit
    @bottom_limit = bottom_limit
    @top_limit = top_limit
    @abs_x = left_limit
    @abs_y = top_limit
    @step_x = step_x
    @step_y = step_y
  end

  def absolute_position
    [@abs_x, @abs_y]
  end

  def absolute_position=(position)
    return if position[0] < @left_limit

    x = position[0].round - @left_limit
    y = position[1].round
    @rel_x = x / @step_x
    @rel_y = y / @step_y
    @abs_x = (@rel_x * @step_x) + @left_limit
    @abs_y = @rel_y * @step_y
  end

  def relative_position
    [@rel_x, @rel_y]
  end

  def left
    return if @abs_x == @left_limit

    @abs_x -= @step_x
    @rel_x -= 1
  end

  def right
    return if @abs_x == @right_limit

    @abs_x += @step_x
    @rel_x += 1
  end

  def up
    return if @abs_y == @top_limit

    @abs_y -= @step_y
    @rel_y -= 1
  end

  def down
    return if @abs_y == @bottom_limit

    @abs_y += @step_y
    @rel_y += 1
  end
end
