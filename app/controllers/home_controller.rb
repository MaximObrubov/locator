class HomeController < ApplicationController

  skip_before_action :verify_authenticity_token, :only => [:near_houses]


  def index
  end

  def near_houses
    @alerts = []
    response = {}
    houses = nil
    response[:alerts] << "no point parameters passed" unless (params[:lat] and params[:long])

    begin
      point = {lat: params[:lat].to_f, long: params[:long].to_f}
      houses = House::near(point: point)
      response[:houses] = houses
    rescue StandardError => err
      @alerts << err.message
    end

    response[:html] = render_to_string partial: "home/house_list", locals: {houses: houses}, :format => :html
    render json: response.to_json
  end
end
