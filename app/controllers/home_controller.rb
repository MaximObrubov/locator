class HomeController < ApplicationController

  skip_before_action :verify_authenticity_token, :only => [:near_houses]


  def index
  end

  def near_houses
    @alerts = []
    response = {}
    @alerts << "no point parameters passed" unless (params[:lat] and params[:long])

    begin
      point = {lat: params[:lat].to_f, long: params[:long].to_f}
      response[:houses] = House::near(point: point)
    rescue StandardError => err
      @alerts << err.message
    end

    render json: response.to_json
  end
end
