# frozen_string_literal: true

require 'dry-initializer'
require 'dry-types'

module ChangeTracking
  class Change
    extend Dry::Initializer

    ADD = "+"
    DELETE = "-"
    ALTER = "~"

    CHANGE_TYPES = [
      ADD,
      ALTER,
      DELETE
    ].freeze

    option :change_type, Types::String.enum(*CHANGE_TYPES)
    option :field, Types::String
    option :from, Types::Any
    option :to, Types::Any

    def object_path
      if field.include?('.')
        field.split('.')[..-2].join
      else
        'self'
      end
    end

    def accessor
      field.split('.')[-1]
    end
  end
end
