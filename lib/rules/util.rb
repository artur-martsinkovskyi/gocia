# frozen_string_literal: true

module Rules
  module Util
    Success = :success?.to_proc
    Failure = :failure?.to_proc
    Pipe = :itself.to_proc

    def satisfies?(rule)
      Pipe >> rule >> Success
    end

    def dissatisfies?(rule)
      Pipe >> rule >> Failure
    end
  end
end
