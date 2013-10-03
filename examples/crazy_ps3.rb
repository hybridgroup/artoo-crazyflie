require 'artoo'

connection :crazyflie, :adaptor => :crazyflie
device :drone, :driver => :crazyflie, :connection => :crazyflie, :interval => 0.1

connection :joystick, :adaptor => :sdl_joystick
device :controller, :driver => :sdl_joystick, :connection => :joystick, :interval => 0.1

work do
  on controller, :joystick => proc { |*value|
    thrust = 1.52
    if value[1][:s] == 0
      if value[1][:y] < 0
        drone.power(value[1][:y].abs * thrust)
      else
        drone.power(0)
      end

    end

    deg = 0.00091
    if value[1][:s] == 1
      if value[1][:y] < 0
        drone.up(value[1][:y].abs * deg)
      elsif value[1][:y] > 0
        drone.down(value[1][:y].abs * deg)
      else
        drone.up(0)
      end 

      if value[1][:x] > 0
        drone.right(value[1][:x].abs * deg)
      elsif value[1][:x] < 0
        drone.left(value[1][:x].abs * deg)
      else
        drone.left(0)
      end 
    end
  }
end
