require 'concurrent'

module World
  class Initializer
    def ready?
      if initialization.fulfilled?
        true
      elsif initialization.rejected?
        raise initialization.reason
      else
        false
      end
    end

    def initialization
      @initialization ||= begin
                            Concurrent::Promises.future do
                              WorldEngine.new
                            end
                          end
    end

    def world_engine
      @world_engine ||= initialization.value
    end
  end
end
