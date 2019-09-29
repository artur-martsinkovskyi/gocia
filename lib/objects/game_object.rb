# frozen_string_literal: true

require 'dry-initializer'
require 'memoist'

class GameObject
  extend Dry::Initializer
  extend Memoist

  def to_h
    {
      type: type
    }
  end

  def type
    self.class.name.downcase
  end
end
