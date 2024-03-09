class SportsController < ApplicationController
     
    def index
        sports = Sport.all
        render json: SportBlueprint.render(sports), status: :ok
    end
  end
  