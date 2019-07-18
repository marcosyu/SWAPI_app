class FilmsController < ApplicationController

  def index
    data = SwapiService.new("films/").call_all
    @films = data
  end

  def show
    @film = SwapiService.new("films/#{params[:id]}/").call
  end

end
