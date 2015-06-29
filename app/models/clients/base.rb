module Clients
  class Base

    def initialize
      @hydra = Typhoeus::Hydra.new
    end

    def make_request(uri, callback, options = {})
      request = Typhoeus::Request.new(uri, options.merge(followlocation: true))
      request.on_complete do |response|
        @response = handle_response(response, callback)
      end

      @hydra.queue(request)
      @hydra.run

      @response
    end

    def handle_response(response, callback)
      if response.success?
        on_success(callback, response)
      elsif response.timed_out?
        on_timed_out
      elsif response.code == 0
        on_error(response.return_message)
      else
        on_failure(response.code)
      end
    end

    def on_success(callback = :success_callback, response)
      send(callback, response)
    end

    def success_callback(response)
      Rails.logger.info 'HTTP request was successful'
      true
    end

    def on_timed_out
      Rails.logger.error 'HTTP request timed out'
      false
    end

    def on_error(return_message)
      Rails.logger.error return_message
      false
    end

    def on_failure(response_code)
      Rails.logger.error "HTTP request failed: #{response_code}"
      false
    end
  end
end
