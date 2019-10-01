# frozen_string_literal: true

require 'hashdiff'

module ChangeTracker
  def update(**params)
    old_attributes = deep_attributes
    yield self
    new_attributes = deep_attributes
    changeset = diff(old_attributes, new_attributes).to_h
    changes << [current_tick, changeset]
    @current_change_pointer ||= 0
    @current_change_pointer += 1
    self
  end

  def rollback(by: 1)
    new_change_pointer = if (@current_change_pointer - by).negative?
                           0
                         else
                           @current_change_pointer - by
                         end
    changesets = changes[new_change_pointer..@current_change_pointer]
    changesets.each do |changeset|
      changeset[1].each_pair do |key, changes|
        if key.include?(".")
          parts = key.split(".")
          object = eval(parts[..-2].join)
          object.send("#{parts[-1]}=", changes[0])
        else
          send("#{key}=", changes[0])
        end
      end
    end
    @current_change_pointer = new_change_pointer
    self
  end

  def rollup(by: changes.size - @current_change_pointer)
    new_change_pointer = if (@current_change_pointer + by) > changes.size
                           changes.size
                         else
                           @current_change_pointer + by
                         end
    changesets = changes[@current_change_pointer..new_change_pointer]
    changesets.each do |changeset|
      changeset.changes.each_pair do |key, changes|
        eval("#{key}=#{changes.from}", __FILE__, __LINE__)
      end
    end
    @current_change_pointer = new_change_pointer
    self
  end

  private

  def diff(old, new)
    Hashdiff.diff(old, new).select { |diff_entry| diff_entry[0] == '~' }.map { |diff_entry| [diff_entry[1], diff_entry[2, 3]] }
  end

  def changes
    @changes ||= []
  end
end
