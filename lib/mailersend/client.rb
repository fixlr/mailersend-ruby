# frozen_string_literal: true

require 'http'

API_URL = 'https://api.mailersend.com/v1'
API_BASE_HOST = 'api.mailersend.com'

# mailersend-ruby is a gem that integrates all endpoints from MailerSend API
module Mailersend
  attr_reader :api_token

  # Inits the client.
  class Client
    def initialize(api_token = ENV['MAILERSEND_API_TOKEN'])
      if api_token.to_s.empty?
        raise ArgumentError, <<~EOS
          Missing required API token. Did you forget to set the
          MAILERSEND_API_TOKEN env variable?
        EOS
      else
        @api_token = api_token
      end
    end

    def http
      HTTP
        .timeout(connect: 15, read: 30)
        .auth("Bearer #{@api_token}")
        .headers('User-Agent' => "MailerSend-client-ruby/#{Mailersend::VERSION}",
                 'Accept' => 'application/json')
    end
  end
end
