class GameObject
  def to_h
    {
      type: self.class.name
    }
  end
end
