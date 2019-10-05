# frozen_string_literal: true

module ChangeTracker
  def update(&block)
    change_tracker.update(&block)
  end

  def rollback(by: 1)
    change_tracker.rollback(by: by)
  end

  def rollup(by: 1)
    change_tracker.rollup(by: by)
  end

  private

  def change_tracker
    @change_tracker ||= ChangeTracking::Service.new(self)
  end
end
