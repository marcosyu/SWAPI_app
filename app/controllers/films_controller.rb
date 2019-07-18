class FilmsController < ApplicationController

  def index
    data = SwapiService.new("films/").call
    @films = data["results"]
  end

  def show
    @film = SwapiService.new("films/#{params[:id]}/").call
  end

end
