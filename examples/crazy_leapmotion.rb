require 'artoo'

connection :crazyflie, :adaptor => :crazyflie
device :drone, :driver => :crazyflie, :connection => :crazyflie, :interval => 0.01

connection :leap, :adaptor => :leapmotion, :port => '127.0.0.1:6437'
device :leap, :connection => :leap, :driver => :leapmotion

work do
  on leap, :hand => :wave

  every(0.01) do
    if thrust >= power
      power = thrust
    elsif power < degrade
      power = 0
    else
      power = power - degrade
    end
    drone.power(power)
  end

end

def degrade
  700
end

def power= val
  @power = val
end

def power
  @power ||= 0
end

def thrust
  @thrust ||= 0
end

def wave sender, hand
  return unless hand
  @thrust =  hand.palm_z.from_scale(100..800).to_scale(0..60000)
end
