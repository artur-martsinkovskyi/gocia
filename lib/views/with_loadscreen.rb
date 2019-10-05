# frozen_string_literal: true

module WithLoadscreen
  def with_loadscreen(before:)
    if before
      yield
    else
      @loadscreen ||= Loadscreen.new
      @loadscreen.draw
    end
  end
end
