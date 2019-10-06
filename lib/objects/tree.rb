# frozen_string_literal: true

class Tree < GameObject
  has(Fruit, default: proc { Fruit.new.object_id if rand > 0.5 })

  def to_h
    super.merge(
      fruit: fruit&.to_h
    ).compact
  end
end
