module Yandex::Geocoder
  module V1X
    class Client
      API_ENDPOINT = 'https://geocode-maps.yandex.ru/1.x'.freeze

      def initialize()
        @token = ENV['YANDEX_GEOCODER_TOKEN']
      end

    end
  end
end
