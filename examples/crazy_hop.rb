require 'artoo'

connection :crazyflie, :adaptor => :crazyflie, :supports_hover => true
device :drone, :driver => :crazyflie, :connection => :crazyflie, :interval => 0.1

work do
  drone.take_off
  
  after(1.seconds) {drone.stop}
end
