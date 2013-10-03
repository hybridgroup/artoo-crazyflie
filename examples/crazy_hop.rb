require 'artoo'

connection :crazyflie, :adaptor => :crazyflie
device :drone, :driver => :crazyflie, :connection => :crazyflie, :interval => 0.1

work do
  drone.up(0)
  after(1.seconds) {drone.stop}
end
