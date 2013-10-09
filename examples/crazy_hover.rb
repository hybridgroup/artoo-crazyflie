require 'artoo'

connection :crazyflie, :adaptor => :crazyflie, :supports_hover => true
device :drone, :driver => :crazyflie, :connection => :crazyflie, :interval => 0.1

work do
  drone.start
  drone.take_off
  
  after(1.5) {drone.hover(:start)}

  after(3.seconds) {
    drone.land
  }

  after(5.seconds) {
    drone.stop
  }
end
