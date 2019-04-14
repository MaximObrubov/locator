namespace :houses do
  desc "Adds new 50 houses to db"
  task add: :environment do
    geo = Yandex::Geocoder::V1x::Client.new()
    data = geo.point_info(lat: 37.597576, long: 55.7718)

    puts data.inspect
  end

end
