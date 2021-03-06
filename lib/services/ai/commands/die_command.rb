# frozen_string_literal: true

module Ai
  module Commands
    class DieCommand < Command
      def call
        actor.update do |actor|
          actor.stats.alive = false
        end
      end
    end
  end
end
