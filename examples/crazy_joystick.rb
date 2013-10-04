require 'artoo'

connection :crazyflie, :adaptor => :crazyflie
device :drone, :driver => :crazyflie, :connection => :crazyflie, :interval => 0.01

connection :joystick, :adaptor => :joystick
device :controller, :driver => :joystick, :connection => :joystick, :interval => 0.01

work do
  on controller, :joystick => proc { |*value|
    handle_joystick value[1]
  }
end

def handle_joystick data
    thrust_scale = 1.46
    yaw_scale = 0.000191753
    deg_scale = 0.00091
    degrade = 700
    @power = 0 if @power.nil?
    if data[:s] == 0
      thrust = (data[:y] < 0) ? (data[:y].abs * thrust_scale) : 0
      if thrust >= @power
        @power = thrust
      elsif @power < degrade
        @power = 0
      else
        @power = @power - degrade
      end
      drone.power(@power)

      if data[:x] > 0
        drone.turn_right(data[:x].abs * yaw_scale)
      elsif data[:x] < 0
        drone.turn_left(data[:x].abs * yaw_scale)
      else
        drone.turn_left(0)
      end 
    end

    if data[:s] == 1
      if data[:y] < 0
        drone.forward(data[:y].abs * deg_scale)
      elsif data[:y] > 0
        drone.backward(data[:y].abs * deg_scale)
      else
        drone.forward(0)
      end 

      if data[:x] > 0
        drone.right(data[:x].abs * deg_scale)
      elsif data[:x] < 0
        drone.left(data[:x].abs * deg_scale)
      else
        drone.left(0)
      end 
    end
end
