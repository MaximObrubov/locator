namespace :houses do
  desc "Adds new random 50 houses to db"
  task add: :environment do
    geo = Yandex::Geocoder::V1x::Client.new()
    # TODO: change to 50
    limit = 1

    while limit > 0 do
      p = Moscow::point
      data = geo.objects(
        lat: coords[:lat],
        long: coords[:long],
        kind: 'house',
        amount: 1,
      )
      puts JSON.pretty_generate(data)
      limit -= 1
    end
  end
end
