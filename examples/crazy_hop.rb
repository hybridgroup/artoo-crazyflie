require 'artoo'

connection :crazyflie, :adaptor => :crazyflie
device :drone, :driver => :crazyflie, :connection => :crazyflie, :interval => 0.1

work do
  drone.forward(0)
  drone.set_thrust_on
  after(1.seconds) {drone.stop}
end
