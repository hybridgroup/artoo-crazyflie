require 'artoo'

connection :crazyflie, :adaptor => :crazyflie
device :drone, :driver => :crazyflie_nav, :connection => :crazyflie

work do
  drone.log_value("stabilizer.pitch")  
  drone.start_logging

  every(1.seconds) {
    puts drone.log
  }
end
