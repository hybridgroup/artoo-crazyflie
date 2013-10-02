require 'artoo/adaptors/adaptor'

module Artoo
  module Adaptors
    # Connect to a crazyflie quadcopter
    # @see crazyflie documentation for more information
    class Crazyflie < Adaptor
      attr_reader :crazyflie

      # Creates a connection with crazyflie
      # @return [Boolean]
      def connect
        require 'crubyflie' unless defined?(::Crubyflie)

        @crazyflie = Crazyflie.new('/tmp/crubyflie') # TODO: a real temp file location?
        @crazyflie.open_link(port)

        super
      end

      # Closes connection with device
      # @return [Boolean]
      def disconnect
        @crazyflie.close_link

        super
      end

      # device info interface
      def firmware_name
        "Crazyflie"
      end

      def version
        Crubyflie::VERSION
      end

      # Uses method missing to call device actions
      # @see device documentation
      def method_missing(method_name, *arguments, &block)
        device.send(method_name, *arguments, &block)
      end
    end
  end
end
