# frozen_string_literal: true

require 'concurrent'

class WorldInitializer < Operation
  def ready?
    if initialization.fulfilled?
      true
    elsif initialization.rejected?
      raise initialization.reason
    else
      false
    end
  end

  memoize def initialization
    @initialization ||= begin
                          Concurrent::Promises.future do
                            WorldEngine.new
                          end
                        end
  end

  memoize def world_engine
    initialization.value
  end
end
