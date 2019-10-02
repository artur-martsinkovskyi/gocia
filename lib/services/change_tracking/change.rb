# frozen_string_literal: true

require 'dry-initializer'
require 'dry-types'

module ChangeTracking
  class Change
    extend Dry::Initializer

    option :change_type, Types::String.enum('~', '+', '-')
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
      "#{field.split('.')[-1]}="
    end
  end
end
