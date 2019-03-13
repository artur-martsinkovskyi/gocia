require 'concurrent'

module World
  class Initializer
    attr_reader :world_engine

    def ready?
      if initialization_process.resolved?
        true
      else
        false
      end
    end

    def initialization_process
      @intialization_process ||= begin
                                   Concurrent::Promises.future {
                                     @world_engine = WorldEngine.new
                                   }
                                 end
    end
  end
end
