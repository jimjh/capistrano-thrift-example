#
# Autogenerated by Thrift Compiler (0.9.0)
#
# DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
#

require 'thrift'
require 'my-application_types'

module MyApplication
  module RPC
    class Client
      include ::Thrift::Client

      def ping()
        send_ping()
        return recv_ping()
      end

      def send_ping()
        send_message('ping', Ping_args)
      end

      def recv_ping()
        result = receive_message(Ping_result)
        return result.success unless result.success.nil?
        raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'ping failed: unknown result')
      end

    end

    class Processor
      include ::Thrift::Processor

      def process_ping(seqid, iprot, oprot)
        args = read_args(iprot, Ping_args)
        result = Ping_result.new()
        result.success = @handler.ping()
        write_result(result, oprot, 'ping', seqid)
      end

    end

    # HELPER FUNCTIONS AND STRUCTURES

    class Ping_args
      include ::Thrift::Struct, ::Thrift::Struct_Union

      FIELDS = {

      }

      def struct_fields; FIELDS; end

      def validate
      end

      ::Thrift::Struct.generate_accessors self
    end

    class Ping_result
      include ::Thrift::Struct, ::Thrift::Struct_Union
      SUCCESS = 0

      FIELDS = {
        SUCCESS => {:type => ::Thrift::Types::STRING, :name => 'success'}
      }

      def struct_fields; FIELDS; end

      def validate
      end

      ::Thrift::Struct.generate_accessors self
    end

  end

end
