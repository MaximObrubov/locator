namespace :houses do
  desc "Adds new 50 houses to db"
  task add: :environment do
    geo = YandexGeocoderApi::V1X::Client.new()
  end

end
