class SwapiService

  def initialize(url)
    @url = url
  end

  def call
    response =  Faraday.get(Settings.swapi_root_url+ @url)
    return JSON.parse(response.body)
  end

end
