require 'artoo'

connection :crazyflie, :adaptor => :crazyflie, :supports_hover => true
device :drone, :driver => :crazyflie, :connection => :crazyflie, :interval => 0.01

connection :leap, :adaptor => :leapmotion, :port => '127.0.0.1:6437'
device :leap, :connection => :leap, :driver => :leapmotion

work do
  on leap, :hand => :wave
  every(0.1) do
    handle_thrust
  end
end

def handle_thrust
  @degrade = 700
  @power = 0 if @power.nil?
  @thrust = 0 if @thrust.nil?
  if @thrust >= @power
    @power = @thrust
    @thrust = 0
  elsif @power < @degrade
    @power = 0
  else
    @power = @power - @degrade
  end
  drone.power(@power)
end

def wave sender, hand
  return unless hand
  @thrust =  hand.palm_z.from_scale(100..800).to_scale(0..60000)
end
