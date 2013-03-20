require 'thrift'
require 'thor'
require 'pry'

gen = Pathname.new(__FILE__).dirname + '..' + '..' + 'gen'
$:.push gen
require gen + 'r_p_c'

# NOTE: you might want a `:host` option as well for each of these
module MyApplication

  class Cli < Thor

    desc 'server', 'launch a thrift server at specified port'
    option :port,       type: :numeric, default: 3000
    option :'log-file', type: :string, default: nil
    def server
      # NOTE use :log-file however you wish here
      socket = Thrift::ServerSocket.new 'localhost', options['port']
      processor = RPC::Processor.new RPC::Handler.new
      factory   = Thrift::BufferedTransportFactory.new
      server    = Thrift::ThreadPoolServer.new processor, socket, factory
      server.serve
    end

    desc 'client', 'use a command-line client'
    option :port, type: :numeric, default: 3000
    def client
      socket = Thrift::Socket.new 'localhost', options['port']
      transport = Thrift::BufferedTransport.new socket
      protocol = Thrift::BinaryProtocol.new transport
      client   = RPC::Client.new protocol
      begin
        transport.open
        client.pry
      ensure
        transport.close
      end
    end

  end

  module RPC
    class Handler
      def ping
        'pong!'
      end
    end
  end

end
