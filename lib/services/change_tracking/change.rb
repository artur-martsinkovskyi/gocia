# frozen_string_literal: true

require 'dry-struct'

module ChangeTracking
  class Change < Dry::Struct
    ADD = '+'
    REMOVE = '-'
    ALTER = '~'

    CHANGE_TYPES = [
      ADD,
      ALTER,
      REMOVE
    ].freeze

    attribute :change_type, Types::String.enum(*CHANGE_TYPES)
    attribute :field, Types::String
    attribute :from, Types::Any
    attribute :to, Types::Any

    def object_path
      if field.include?('.')
        field.split('.')[..-2].join('.')
      else
        'self'
      end
    end

    def accessor
      field.split('.')[-1]
    end
  end
end
