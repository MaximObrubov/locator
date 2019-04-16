class HomeController < ApplicationController

  skip_before_action :verify_authenticity_token, :only => [:near_objects]


  def index
  end


  def near_objects radius: 4

    puts params[:lat]
    puts params[:long]
    puts "*" * 45

    render json: params.to_json
  end
end
