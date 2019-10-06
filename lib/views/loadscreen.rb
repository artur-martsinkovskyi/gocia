# frozen_string_literal: true

require 'securerandom'

class Loadscreen
  include Dimensions
  include Fonts
  include Images

  attr_reader :title, :image

  def initialize
    @title = Gosu::Image.from_text(
      '
SOCIA      EXISTENTIAL SIMULATOR
by ARTUR MARTSINKOVSKYI
      ',
      300,
      font: AMATIC_REGULAR
    )
    @image = Gosu::Image.new(HEXAGON)
    @rotator = Rotator.call(angle: 25)
  end

  def draw
    title.draw(145, 20, 0, 0.5, 0.5, Gosu::Color::WHITE)
    image.draw_rot(400, 240, 0, rotator.next, 0.5, 0.5, 0.2, 0.2, Gosu::Color::WHITE)
    Gosu.draw_rect(
      0,
      HEIGHT - 200,
      WIDTH,
      100,
      Gosu::Color::WHITE
    )
    Gosu::Image.from_text(
      SecureRandom.alphanumeric(50),
      100,
      font: VT323_REGULAR
    ).draw(0, HEIGHT - 200, 0, 1, 1, Gosu::Color::BLACK)
  end

  private

  attr_reader :rotator
end
