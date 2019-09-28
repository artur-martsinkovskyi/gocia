# frozen_string_literal: true

require 'dry-types'
require 'rspec/mocks/standalone'

module Types
  include Dry.Types

  # rubocop:disable Naming/MethodName
  def self.Instance(klass)
    Dry.Types.Instance(klass) | Dry.Types.Instance(RSpec::Mocks::Double)
  end
  # rubocop:enable Naming/MethodName
end
