require 'rails_helper'

RSpec.describe House, type: :model do
  it "is valid with valid parameters" do
    expect(House.new(address: 'address', lat: Moscow::COORDS[:lat], long: Moscow::COORDS[:long])).to be_valid
  end

  it "is not valid with empty parameters" do
    h1 = House.new(address: nil, lat: Moscow::COORDS[:lat], long: Moscow::COORDS[:long])
    h2 = House.new(address: 'address1', lat: nil, long: Moscow::COORDS[:long])
    h3 = House.new(address: 'address2', lat: Moscow::COORDS[:lat], long: nil)
    expect(h1).to_not be_valid
    expect(h2).to_not be_valid
    expect(h3).to_not be_valid
  end

  it "is not valid out of Moscow" do
    h1 = House.new(address: 'address1', lat: Moscow::min_lat - 0.1, long: Moscow::COORDS[:long])
    h2 = House.new(address: 'address2', lat: Moscow::min_lat, long: Moscow::min_long - 0.1)
    expect(h1).to_not be_valid
    expect(h2).to_not be_valid
  end

  it "should not be possible to create house with same address" do
    House.create!(address: 'address', lat: Moscow::COORDS[:lat], long: Moscow::COORDS[:long])
    h2 = House.new(address: 'address', lat: Moscow::COORDS[:lat], long: Moscow::COORDS[:long])
    expect(h2).to_not be_valid
    expect(h2.errors[:address]).to include("has already been taken")
  end

end
