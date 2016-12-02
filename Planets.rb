require "gosu"
require_relative "z_order"

class Planets

  def initialize(x_pos, y_pos, x_vel, y_vel, mass, image, size_of_simulation)
    @x_pos = x_pos
    @y_pos = y_pos
    @x_vel = x_vel
    @y_vel = y_vel
    @mass = mass
    @image = image
    @size_of_simulation = size_of_simulation
    @adjusted_x_pos = (@x_pos * 320/@size_of_simulation) + 320
    @adjusted_y_pos = (@y_pos * 320/@size_of_simulation) + 320
  end

  def draw
    @image.draw(@adjusted_x_pos, @adjusted_y_pos, ZOrder::Bodies)
  end

  def update
  end

end
