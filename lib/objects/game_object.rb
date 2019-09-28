# frozen_string_literal: true

require 'dry-types'
require 'dry-initializer'

class GameObject
  extend Dry::Initializer

  def to_h
    {
      type: type
    }
  end

  def type
    self.class.name.downcase
  end
end
