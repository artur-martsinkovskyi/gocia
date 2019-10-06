# frozen_string_literal: true

class GameObject
  extend Dry::Initializer
  extend Memoist

  include ChangeTracker
  include ObjectSystem

  def to_h
    {
      id: object_id,
      type: type
    }
  end

  def type
    self.class.name.downcase
  end

  def deep_attributes
    attributes.map do |key, value|
      if value.is_a?(GameObject)
        [key, value.deep_attributes]
      else
        [key, value]
      end
    end.to_h
  end

  def tick
    $world.tick
  end

  def attributes
    self.class.dry_initializer.attributes(self)
  end
end
