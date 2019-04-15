module Moscow extend self
  COORDS = {
    lat: 55.75583,
    long: 37.61778,
    range_lat: 0.057147,
    range_long: 0.117635,
  }.freeze

  def point
    {
      lat: rand(min_lat..max_lat).round(6),
      long: rand(min_long..max_long).round(6),
    }
  end

  private

  def min_lat
    COORDS[:lat] - COORDS[:range_lat]
  end

  def max_lat
    COORDS[:lat] + COORDS[:range_lat]
  end

  def min_long
    COORDS[:long] - COORDS[:range_long]
  end

  def max_long
    COORDS[:long] + COORDS[:range_long]
  end

end
