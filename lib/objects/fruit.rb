# frozen_string_literal: true

class Fruit < GameObject
  option(:poisonous, Types::Bool, default: proc { rand < 0.1 })

  def poisonous?
    poisonous
  end

  def to_h
    super.merge(
      poisonous: poisonous?
    )
  end
end
