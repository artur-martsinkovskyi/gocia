# frozen_string_literal: true

module Slates
  class Contents < Array
    def deep_attributes
      map do |item|
        [
          item.class,
          item.object_id
        ]
      end
    end
  end
end
