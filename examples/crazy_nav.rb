require 'artoo'

connection :crazyflie, :adaptor => :crazyflie, :supports_hover => true
#device :commander, :driver => :crazyflie, :connection => :crazyflie
device :drone, :driver => :crazyflie_nav, :connection => :crazyflie

work do
  #commander.start

  #puts drone.toc
  # drone.start_get_value("pid_attitude.pitch_kp")
  # drone.start_get_value("pid_attitude.pitch_ki")
  # drone.start_get_value("pid_attitude.pitch_kd")
  drone.log_value("stabilizer.pitch")  
  drone.start_logging

  every(1.seconds) {
    puts drone.log
    #puts drone.values["pid_attitude.pitch_kp"]
    #puts drone.values["pid_attitude.pitch_ki"]
    #puts drone.values["pid_attitude.pitch_kd"]
  }
end
