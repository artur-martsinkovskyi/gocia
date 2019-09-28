# frozen_string_literal: true

require 'dry-struct'

module ViewObjects
  class ViewObject < Dry::Struct
    attribute :x, Types::Integer
    attribute :y, Types::Integer
  end
end
