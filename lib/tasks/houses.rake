namespace :houses do
  desc "Adds new random 50 houses to db"
  task add: :environment do
    geo = Yandex::Geocoder::V1x::Client.new()
    # TODO: change to 50
    limit = 1

    while limit > 0 do
      coords = rand_in_moscow
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

  def rand_in_moscow
    # TODO: find out what is the best way to store static object like `moscow`
    # should be moved to static model or putted in da base
    moscow = {
      long: {
        max: 55.818812,
        min: 55.704519,
      },
      lat: {
        max: 37.717317,
        min: 37.482048,
      }
    }
    {
      lat: rand(moscow[:lat][:min]..moscow[:lat][:max]).round(6),
      long: rand(moscow[:long][:min]..moscow[:long][:max]).round(6),
    }
  end
end
