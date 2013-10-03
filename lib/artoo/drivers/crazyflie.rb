require 'artoo/drivers/driver'

module Artoo
  module Drivers
    # The crazyflie driver behaviors
    class Crazyflie < Driver
      COMMANDS = [:start, :stop, :hover, :land, :take_off, :emergency, 
                  :up, :down, :left, :right, :forward, :backward, 
                  :turn_left, :turn_right, :power].freeze


      attr_reader :roll, :pitch, :yaw, :thrust, :xmode

      def initialize(params={})
        @roll = 0
        @pitch = 0
        @yaw = 0
        @thrust = 0
        @xmode = false # TODO what is this?
        super
      end

      # Start driver and any required connections
      def start_driver
        begin
          every(interval) do
            send_command
          end

          super
        rescue Exception => e
          Logger.error "Error starting Crazyflie driver!"
          Logger.error e.message
          Logger.error e.backtrace.inspect
        end
      end

      def start
        @roll = 0
        @pitch = 0
        @yaw = 0
        @thrust = 10001
      end

      def stop
        set_thrust_off
      end

      def hover
        # TODO: call firmware that can do this?
      end

      def land
      end

      def take_off
      end

      def power(deg)
        @thrust = deg
      end

      def forward(deg)
        @pitch = deg
      end

      def backward(deg)
        @pitch = -deg
      end

      def left(deg)
        @roll = -deg
      end

      def right(deg)
        @roll = deg
      end

      def turn_left(deg)
        @yaw = -deg
      end

      def turn_right(deg)
        @yaw = deg
      end
      
      def set_thrust_on
        @thrust = 40000
      end

      def set_thrust_off
        @thrust = 0
      end

    private

      def send_command
        connection.commander.send_setpoint(roll, pitch, yaw, thrust, xmode)
      end
    end
  end
end
