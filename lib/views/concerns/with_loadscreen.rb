module WithLoadscreen
  def with_loadscreen(_until:)
    if _until
      yield
    else
      @loadscreen = Loadscreen.new unless @loadscreen
      @loadscreen.draw
    end
  end
end

