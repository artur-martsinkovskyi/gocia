# frozen_string_literal: true

require 'hashdiff'

module ChangeTracking
  class Service
    attr_reader :object, :current_change_tick, :changesets

    def initialize(object)
      @object = object
      @changesets = []
    end

    def update
      old_attributes = Marshal.load(
        Marshal.dump(
          object.deep_attributes
        )
      )
      yield object
      new_attributes = object.deep_attributes
      change_attributes = diff(old_attributes, new_attributes)
      return object unless change_attributes.any?

      changes = change_attributes.map do |change_type, field, from, to|
        Change.new(
          change_type: change_type,
          field: field,
          from: from,
          to: to
        )
      end
      changesets << Changeset.new(
        tick: object.tick,
        changes: changes
      )
      self.current_change_tick = object.tick
      object
    end

    def rollback(to:)
      relevant_changesets = changesets.reverse_each.take_while { |changeset| changeset.tick >= to }
      relevant_changesets.each do |changeset|
        changeset.changes.each do |change|
          ChangeProcessor.call(object, change, direction: :rollback)
        end
      end
      self.current_change_tick = relevant_changesets.last.tick if relevant_changesets.any?
      object
    end

    def rollup(to:)
      relevant_changesets = changesets.take_while { |changeset| changeset.tick <= to }
      relevant_changesets.each do |changeset|
        changeset.changes.each do |change|
          ChangeProcessor.call(object, change, direction: :rollup)
        end
      end
      self.current_change_tick = relevant_changesets.last.tick if relevant_changesets.any?
      object
    end

    private

    attr_writer :current_change_tick

    def diff(old, new)
      Hashdiff.diff(old, new)
    end
  end
end
