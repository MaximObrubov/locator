namespace :houses do
  desc "Adds new 50 houses to db"
  task add: :environment do
    geo = Yandex::Geocoder::V1x::Client.new()
  end

end
