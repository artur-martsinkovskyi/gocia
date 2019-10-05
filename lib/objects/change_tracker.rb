# frozen_string_literal: true

module ChangeTracker
  def update(&block)
    change_tracker.update(&block)
  end

  def rollback(to:)
    change_tracker.rollback(to: to)
  end

  def rollup(to:)
    change_tracker.rollup(to: to)
  end

  private

  def change_tracker
    @change_tracker ||= ChangeTracking::Service.new(self)
  end
end
