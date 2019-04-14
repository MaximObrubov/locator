module Yandex::Geocoder::V1x

  class Client
    API_ENDPOINT = 'https://geocode-maps.yandex.ru/1.x'.freeze

    def initialize()
      @token = ENV['YANDEX_GEOCODER_TOKEN']

      puts @token

    end

  end

end
