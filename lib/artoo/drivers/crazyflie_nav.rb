require 'artoo/drivers/driver'

module Artoo
  module Drivers
    # The crazyflie driver behaviors
    class CrazyflieNav < Driver
      COMMANDS = [:set_value, :start_get_value, :toc, :values, :log].freeze

      attr_reader :values, :log

      # Start driver and any required connections
      def start_driver
        begin
          @values = {}
          @log = {}

          super
        rescue Exception => e
          Logger.error "Error starting Crazyflie nav driver!"
          Logger.error e.message
          Logger.error e.backtrace.inspect
        end
      end

      def toc
        connection.param.toc
      end

      def set_value(name, value)        
        connection.param.set_value(name, value) do |val|
          @values[value] = val
        end
      end

      def start_get_value(value)        
        connection.param.get_value(value) do |val|
          @values[value] = val
        end
      end

      def log_value(value, x=true, y=7, z=7)
        @log_conf_var = ::Crubyflie::LogConfVariable.new(value, x, y, z)
      end

      def start_logging
        # We want to fetch it every 0.1 secs
        @log_conf = ::Crubyflie::LogConf.new([@log_conf_var], {:period => 10})

        # With the configuration object, register a log_block
        @block_id = connection.log.create_log_block(@log_conf)

        # Start logging
        connection.log.start_logging(@block_id) do |data|
          @log = data
        end        
      end
    end
  end
end
