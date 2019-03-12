class Loadscreen
  include Dimensions
  include Fonts


  def initialize
    @content = Gosu::Image.from_text(
      %q{
      SOCIA ⬢  EXISTENTIAL SIMULATOR
      by ARTUR MARTSINKOVSKYI
      },
      300,
      font: AMATIC_REGULAR
    )
  end

  def draw
    @content.draw(20, 20, 0, 0.5, 0.5, Gosu::Color::WHITE)
  end
end
