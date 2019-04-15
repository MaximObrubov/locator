namespace :houses do
  desc "Adds new random 50 houses to db"
  task add: :environment do
    geo = Yandex::Geocoder::V1x::Client.new()
    # TODO: change to 50
    limit = 50
    # if 10x tryings not led to required addresses amount,
    # it probably bad coordinates or dead api
    hard_limit = limit * 10

    while (limit > 0 and hard_limit > 0) do
      p = Moscow::point

      begin
        if ENV['TEST']
          address = "Address, #{limit}"
          House.create!(address: address, lat: p[:lat], long: p[:long])
        else
          data = geo.objects(
            lat: p[:lat],
            long: p[:long],
            kind: 'house',
            amount: 1,
          )
          house = data["response"]["GeoObjectCollection"]["featureMember"][0]["GeoObject"]
          address = house["metaDataProperty"]["GeocoderMetaData"]["Address"]["formatted"]
          coords = house["Point"]["pos"].split

          # TODO: replace with
          # House.create(address: address, lat: coords[1], long: coords[0])
          puts address
          puts coords
        end

        limit -= 1
      rescue StandardError => err
        STDERR.puts "Data recieve failed: #{err.message}"
      end

      hard_limit -= 1
    end

  end
end
