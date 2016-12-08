require "gosu"
require_relative "z_order"
require "./Planets.rb"
SIMULATION = gets.chomp.to_s

class NbodySimulation < Gosu::Window

  def initialize
    super(640, 640, false)
    self.caption = "NBody simulation"
    @background_image = Gosu::Image.new("images/space.jpg", tileable: true)
    @bodies = []
    @number_of_bodies = 0
    @size_of_simulation = 0
    create_bodies
  end

  def create_bodies
    txt = File.open("simulations/#{SIMULATION}.txt").read
    line_num = 0
    txt.split("\n")
    txt.each_line do |line|
      if line_num == 0
        @number_of_bodies = line.to_f
        line_num += 1
      elsif line_num == 1
        @size_of_simulation = line.to_f
        line_num += 1
      elsif line_num >= 2 && line_num <= 1 + @number_of_bodies && line.length > 4
        line_array = line.split(" ")
        x_pos = line_array[0].to_f
        y_pos = line_array[1].to_f
        x_vel = line_array[2].to_f
        y_vel = line_array[3].to_f
        mass = line_array[4].to_f
        planet_image = Gosu::Image.new("images/#{line_array[5]}", tileable: true)
        @bodies.push(Planets.new(x_pos, y_pos, x_vel, y_vel, mass, planet_image, @size_of_simulation))
        line_num += 1
      end
    end
  end

  def update
    @bodies.each do |body|
      total_x_force = 0
      total_y_force = 0
      @bodies.each do |second_body|
        if body != second_body
          forces = body.calculate_force(second_body)
          total_x_force += forces[0]
          total_y_force += forces[1]
        end
      end
      body.calculate_acceleration(total_x_force, total_y_force)
      body.calculate_velocity
    end
    @bodies.each do |body|
      body.calculate_position
    end
  end

  def draw
    @background_image.draw(0, 0, ZOrder::Background)
    @bodies.each do |body|
      body.draw
    end
  end

  def button_down(id)
    close if id == Gosu::KbEscape
  end

end

window = NbodySimulation.new
window.show
