require 'artoo/drivers/driver'

module Artoo
  module Drivers
    # The crazyflie driver behaviors
    class Crazyflie < Driver
      COMMANDS = [:start, :stop, :hover, :land, :take_off, :emergency, 
                  :up, :down, :left, :right, :forward, :backward, 
                  :turn_left, :turn_right, :power].freeze


      attr_reader :roll, :pitch, :yaw, :thrust, :xmode, :hover_mode

      def initialize(params={})
        @roll = 0
        @pitch = 0
        @yaw = 0
        @thrust = 0
        @xmode = false # TODO what is this?
        @hover_mode = 0
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
        @hover_mode = 0
        @roll = 0
        @pitch = 0
        @yaw = 0
        power(10001)
      end

      def stop
        set_thrust_off
      end

      def hover(h=:start)
        if h == :start
          @hover_mode = 1
          set_thrust_hover
        else
          @hover_mode = 0
          set_thrust_off
        end
      end

      def land(secs=1)
        @hover_mode = 0
        power(32000)

        after(secs) {
          power(22000)
        }
      end

      def take_off(secs=1)
        forward(0)
        set_thrust_on

        after(secs) {
          power(33000)
        }
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
        power(40000)
      end

      def set_thrust_off
        power(0)
      end

      def set_thrust_hover
        power(32597)
      end

    private

      def send_command
        set_thrust_hover if hover_mode == 1
        connection.commander.send_setpoint(roll, pitch, yaw, thrust, xmode, hover_mode)
      end
    end
  end
end
