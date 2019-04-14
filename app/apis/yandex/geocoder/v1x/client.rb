##
# This module gives an ability to request Yandex geocoder API

module Yandex::Geocoder::V1x

  class Client

    API_ENDPOINT = 'https://geocode-maps.yandex.ru'.freeze

    def initialize()
      raise "No geoapi token provided" unless ENV['YANDEX_GEOCODER_TOKEN']
      @token = ENV['YANDEX_GEOCODER_TOKEN']
    rescue StandardError => err
      puts "ERROR: #{err.message}"
    end


    ##
    # Gets point info by coordinates
    #
    def point_info lat:, long:
      request({
        http_method: :get,
        params: {geocode: "#{lat},#{long}"}
      })
    end


    ##
    # Gets closes to coordinate object
    #
    # +kind+ - type of objects
    # +amount+ - limitation of the collection
    def objects lat:, long:, kind:, amount: 1
      request({
        http_method: :get,
        params: {
          geocode: "#{lat},#{long}",
          results: amount,
          kind: kind
        }
      })
    end


    private

    def adapter
      @_adapter ||= Faraday.new(API_ENDPOINT) do |adapter|
        adapter.adapter Faraday.default_adapter
        adapter.ssl.verify = OpenSSL::SSL::VERIFY_PEER
      end
    end

    def request http_method:, endpoint: '1.x/', params: {}
      params[:apikey] = @token
      params[:format] = 'json'
      response = adapter.public_send(http_method, endpoint, params)
      Oj.load(response.body)
    end

  end

end
