require_relative '../../constants/dimensions'

class MoveCommand
  include Dimensions

  attr_reader :actor

  def call(entity)
    @actor = entity
    @previous_slate = entity.slate
    slates = surrounding_slates(actor.slate.x, actor.slate.y)
    slate = slates.sample
    change_slate(slate)
  end

  def redo
    call
  end

  def undo
    change_slate(@previous_slate)
    @previous_slate = nil
  end

  private

  def change_slate(slate)
    actor.slate.contents.delete(actor)
    actor.slate = slate
    slate.contents.add(actor)
  end

  def surrounding_slates(x, y)
    [x - 1, x, x + 1].map do |xx|
      [y - 1, y, y + 1].map do |yy|
        next if xx == x && yy == y
        next if yy < 0 || yy > TILE_COUNT
        next if xx < 0 || xx > TILE_COUNT

        actor.world.slates[xx][yy]
      end
    end.flatten.compact
  end
end
