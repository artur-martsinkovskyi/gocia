module WithLoadscreen
  def with_loadscreen
    if @loadscreen
      yield
    else
      @loadscreen = Loadscreen.new
      @loadscreen.draw
    end
  end
end

