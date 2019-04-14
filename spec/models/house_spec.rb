require 'rails_helper'

RSpec.describe House, type: :model do
  it "is valid with valid attributes" do
    expect(House.new(address: 'address', lat: 10.000, long: 20.000)).to be_valid
  end

  it "is not valid with empty parameters" do
    h1 = House.new(address: nil, lat: 10.000, long: 20.000)
    h2 = House.new(address: 'address', lat: nil, long: 20.000)
    h3 = House.new(address: 'address', lat: 10.000, long: nil)
    expect(h1).to_not be_valid
    expect(h2).to_not be_valid
    expect(h3).to_not be_valid
  end

  it "not valid with not valid latitude and longitude" do
    h1 = House.new(address: 'address', lat: -91.1, long: 20.000)
    h2 = House.new(address: 'address', lat: -90, long: 181)
    expect(h1).to_not be_valid
    expect(h2).to_not be_valid
  end

end
