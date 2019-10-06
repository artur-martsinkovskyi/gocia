# frozen_string_literal: true

require 'dry-struct'
require 'memoist'

class Service < Dry::Struct
  extend Memoist

  def self.call(*args)
    attributes = args.last.is_a?(Hash) ? args.pop : {}
    names = schema.keys.map(&:name)
    args.each_with_index do |value, index|
      attributes[names[index]] = value
    end
    new(attributes).call
  end
end
