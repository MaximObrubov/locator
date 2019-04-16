class HomeController < ApplicationController

  skip_before_action :verify_authenticity_token, :only => [:near_objects]


  def index
  end

  def near_houses
    render json: params.to_json
  end
end
