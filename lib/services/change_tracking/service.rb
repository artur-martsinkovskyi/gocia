# frozen_string_literal: true

require 'hashdiff'

require_relative 'change'
require_relative 'changeset'

module ChangeTracking
  class Service
    attr_reader :object, :current_change_pointer, :changesets

    def initialize(object)
      @object = object
      @current_change_pointer = 0
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
      changes = change_attributes.map do |change_type, field, from, to|
        Change.new(
          change_type: change_type,
          field: field,
          from: from,
          to: to
        )
      end
      changesets << Changeset.new(
        tick: object.current_tick,
        changes: changes
      )
      self.current_change_pointer += 1
      object
    end

    def rollback(by:)
      new_change_pointer = if (current_change_pointer - by).negative?
                             0
                           else
                             current_change_pointer - by
                           end
      relevant_changesets = changesets[new_change_pointer..current_change_pointer]
      relevant_changesets.each do |changeset|
        changeset.changes.reject { |change| change.change_type == '+' }.each do |change|
          receiver = object.instance_eval(change.object_path)
          receiver.send(change.accessor, change.from)
        end
      end
      self.current_change_pointer = new_change_pointer
      object
    end

    def rollup(by: changes.size - current_change_pointer)
      new_change_pointer = if (current_change_pointer + by) > changes.size
                             changes.size
                           else
                             current_change_pointer + by
                           end
      changesets = changes[current_change_pointer..new_change_pointer]
      changesets.each do |changeset|
        changeset.changes.reject { |change| change.change_type == '+' }.each do |change|
          receiver = object.instance_eval(change.object_path)
          receiver.send(change.accessor, change.from)
        end
      end
      self.current_change_pointer = new_change_pointer
      object
    end

    private

    attr_writer :current_change_pointer

    def diff(old, new)
      Hashdiff.diff(old, new)
    end
  end
end
