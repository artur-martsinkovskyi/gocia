# frozen_string_literal: true

require 'dry/logic'
require 'dry/logic/predicates'
require 'dry/logic/operations'
require_relative 'util'
require_relative '../objects/tree'
require_relative '../objects/fruit'

module Rules
  module Slates
    include Dry::Logic
    include Util

    IsTree = Rule::Predicate.new(Predicates[:type?]).curry(Tree)
    IsTreeWithFruit = IsTree & Operations::Attr.new(Rule::Predicate.new(Predicates[:not_eql?]).curry(nil), name: :fruit)
  end
end
