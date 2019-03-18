# frozen_string_literal: true

class GameObject
  def to_h
    {
      type: self.class.name
    }
  end
end
