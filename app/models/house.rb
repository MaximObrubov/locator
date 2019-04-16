class House < ApplicationRecord
  validates :address, presence: true, uniqueness: true
  validates :lat, presence: true, numericality: {greater_than_or_equal_to: Moscow::min_lat, less_than_or_equal_to: Moscow::max_lat}
  validates :long, presence: true, numericality: {greater_than_or_equal_to: Moscow::min_long, less_than_or_equal_to: Moscow::max_long}

  def self.near point:, radius: 4_000
    all.map {|h| {instance: h, distance: distance(h, point)}}
       .select {|o| o[:distance] <= radius}
       .sort_by {|o| o[:distance]}
  end

  ##
  # gets distance between to points by coordinates
  # using https://en.wikipedia.org/wiki/Haversine_formula
  def self.distance p1, p2
    k = Math::PI / 180
    pr1, pr2 = [p1, p2].map {|p| {lat: p[:lat] * k, long: p[:long] * k} }

    n = Math.sin((pr2[:lat] - pr1[:lat]) / 2) ** 2 + \
        Math.cos(pr1[:lat]) * Math.cos(pr1[:lat]) * \
        Math.sin((pr2[:long] - pr1[:long]) / 2) ** 2
    c = 2 * Math::atan2(Math::sqrt(n), Math::sqrt(1 - n))

    (Earth::RADIUS * c).to_i
  end
end
