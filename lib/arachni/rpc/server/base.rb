=begin
    Copyright 2010-2014 Tasos Laskos <tasos.laskos@gmail.com>
    All rights reserved.
=end

require 'ostruct'
require 'arachni/rpc'
require_relative '../serializer'

module Arachni
module RPC
class Server

# RPC server class
#
# @author Tasos "Zapotek" Laskos <tasos.laskos@gmail.com>
class Base < Server

    # @param    [Arachni::Options]   options
    #   Relevant options:
    #
    #     * {OptionGroups::RPC#server_address}
    #     * {OptionGroups::RPC#server_port}
    #     * {OptionGroups::RPC#server_socket}
    #     * {OptionGroups::RPC#ssl_ca}
    #     * {OptionGroups::RPC#client_ssl_private_key}
    #     * {OptionGroups::RPC#client_ssl_certificate}
    # @param    [String]    token     Optional authentication token.
    def initialize( options, token = nil )
        if options.is_a?( Hash )
            original_options = options
            options     = OpenStruct.new
            options.rpc = OpenStruct.new( original_options )
        end

        super(
            serializer: Serializer,
            host:       options.rpc.server_address,
            port:       options.rpc.server_port,
            socket:     options.rpc.server_socket,
            token:      token,
            ssl_ca:     options.rpc.ssl_ca,
            ssl_pkey:   options.rpc.server_ssl_private_key,
            ssl_cert:   options.rpc.server_ssl_certificate
        )
    end

    def start
        super
        @ready = true
    end

    def ready?
        @ready ||= false
    end

end

end
end
end
