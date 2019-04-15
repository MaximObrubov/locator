class House < ApplicationRecord
  validates :address, presence: true, uniqueness: true
  validates :lat, presence: true, numericality: {greater_than_or_equal_to: Moscow::min_lat, less_than_or_equal_to: Moscow::max_lat}
  validates :long, presence: true, numericality: {greater_than_or_equal_to: Moscow::min_long, less_than_or_equal_to: Moscow::max_long}
end
