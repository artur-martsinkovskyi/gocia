module WithLoadscreen
  def with_loadscreen(_until:)
    if _until
      yield
    else
      @loadscreen ||= Loadscreen.new
      @loadscreen.draw
    end
  end
end

