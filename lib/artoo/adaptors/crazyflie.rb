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
        @crazyflie = ::Crubyflie::Crazyflie.new('/tmp/test')
        source = additional_params[:source] || ""
        if source.empty?
          flies = @crazyflie.scan_interface
          if flies.empty?
            raise "No crazyflies!"
          end
          source = flies.first
        end
        t = @crazyflie.open_link(source)
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
        @crazyflie.send(method_name, *arguments, &block)
      end
    end
  end
end
