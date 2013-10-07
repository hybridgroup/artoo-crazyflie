require 'artoo'

connection :crazyflie, :adaptor => :crazyflie, :supports_hover => true
device :drone, :driver => :crazyflie, :connection => :crazyflie, :interval => 0.01

connection :joystick, :adaptor => :joystick
#device :controller, :driver => :xbox360, :connection => :joystick, :interval => 0.01
device :controller, :driver => :ps3, :connection => :joystick, :interval => 0.01
#device :controller, :driver => :joystick, :connection => :joystick, :interval => 0.01

work do
  on controller, :joystick_0 => :handle_joystick_0
  on controller, :joystick_1 => :handle_joystick_1
  on controller, :button_x => :handle_hover
end

def handle_joystick_0 caller, data
  thrust_scale = 1.46
  yaw_scale = 0.000191753
  degrade = 700
  @power = 0 if @power.nil?
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

def handle_joystick_1 caller, data
  deg_scale = 0.00091

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

def handle_hover caller
  if @hover
    @hover = false
    drone.hover(:stop)
  else
    @hover = true
    drone.hover
  end  
end
