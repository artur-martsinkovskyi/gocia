# frozen_string_literal: true

require 'dry-initializer'
require 'memoist'
require_relative 'concerns/change_tracker'

class GameObject
  extend Dry::Initializer
  extend Memoist

  def initialize(*)
    self.class.object_pool[object_id] = self
    super
  end

  def self.object_pool
    @object_pool ||= {}
  end

  def to_h
    {
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

  def attributes
    self.class.dry_initializer.attributes(self).reject { |k, _| %i[world].include?(k) }
  end
end
