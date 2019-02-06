class Position
  def initialize(step_x:, step_y: step_x, position_x: 0, position_y: 0)
    @rel_x = 0
    @rel_y = 0
    @left_limit = position_x
    @abs_x = position_x
    @abs_y = position_y
    @step_x = step_x
    @step_y = step_y
  end

  def absolute_position
    [@abs_x, @abs_y]
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
    @abs_x += @step_x
    @rel_x += 1
  end

  def up
    @abs_y -= @step_y
    @rel_y -= 1
  end

  def down
    @abs_y += @step_y
    @rel_y += 1
  end
end
