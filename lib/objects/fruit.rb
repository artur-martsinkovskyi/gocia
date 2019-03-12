class Fruit
  def initialize
    @poisonous = rand < 0.1
  end

  def poisonous?
    @poisonous
  end

  def to_h
    {
      poisonous: poisonous?
    }
  end
end
