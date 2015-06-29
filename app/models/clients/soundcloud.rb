module Clients
  class Soundcloud < Clients::Base

    API_ENDPOINT = 'https://api.soundcloud.com'

    def playlists(options = {})
      make_request(resource_uri('playlists', options), :playlists_callback)
    end

    private

    def playlists_callback(response)
      Oj.load(response.body)
      # playlists = Oj.load(response.body).fetch('playlists', [])

      # playlists.map do |playlist|
      #   {

      #   }
      # end
    end

    def resource_uri(endpoint, options = {})
      query = URI.encode(options[:query])

      case endpoint
      when 'playlists'
        "#{API_ENDPOINT}/playlists.json?q=#{query}&#{client_id_string}"
      end
    end

    def client_id_string
      "client_id=#{Rails.application.secrets.soundcloud['client_id']}"
    end
  end
end
