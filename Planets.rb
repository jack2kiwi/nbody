require "gosu"
require_relative "z_order"
Gravity = (6.67408 * (10 ** -11))

class Planets

  attr_accessor :mass, :image, :size_of_simulation
  attr_reader :x_pos, :y_pos

  def initialize(x_pos, y_pos, x_vel, y_vel, mass, image, size_of_simulation)
    @mass = mass
    @image = image
    @size_of_simulation = size_of_simulation
    @x_pos = x_pos
    @y_pos = y_pos
    @x_vel = x_vel
    @y_vel = y_vel
    @x_acc = 0
    @y_acc = 0
  end

  def draw
    @image.draw_rot((@x_pos * 320/@size_of_simulation + 320), (@y_pos * 320/@size_of_simulation + 320), ZOrder::Bodies, 0)
  end

  def calculate_force(other_body)
    radius = Math.sqrt((@x_pos - other_body.x_pos)**2 + (@y_pos - other_body.y_pos)**2)
    force = -(Gravity * @mass * other_body.mass)/(radius ** 2)
    x_force = (force * (@x_pos - other_body.x_pos)) / radius
    y_force = (force * (@y_pos - other_body.y_pos)) / radius
    return [x_force, y_force]
  end

  def calculate_acceleration(x_force, y_force)
    @x_acc = x_force / @mass
    @y_acc = y_force / @mass
  end

  def calculate_velocity
    @x_vel = @x_vel + @x_acc * 25000
    @y_vel = @y_vel + @y_acc * 25000
  end

  def calculate_position
    @x_pos = @x_pos + @x_vel * 25000
    @y_pos = @y_pos + @y_vel * 25000
  end

end
