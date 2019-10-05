# frozen_string_literal: true

require 'dry/logic'
require 'dry/logic/predicates'
require 'dry/logic/operations'

module SlatesRuleset
  include Dry::Logic
  include UtilRuleset

  IsTree = Rule::Predicate.new(Predicates[:type?]).curry(Tree)
  IsTreeWithFruit = IsTree & Operations::Attr.new(Rule::Predicate.new(Predicates[:not_eql?]).curry(nil), name: :fruit)
end
