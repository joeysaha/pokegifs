class PokemonController < ApplicationController
  def show
    # @pokemon = Pokemon.find(params[:id])

    res = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{params[:id]}/")
    body = JSON.parse(res.body)
    id = body["id"]
    name = body["name"] # should be "pikachu"
    types = body["types"]

    if params[:id].is_a?(String)
      res = HTTParty.get("https://api.giphy.com/v1/gifs/search?api_key=#{ENV["GIPHY_KEY"]}&q=#{name}&rating=g")
      body = JSON.parse(res.body)
      url = body["data"][0]["url"]

      render json: { "id": id, "name": name, "types": types, "url": url }
    elsif params[:id].is_a?(Integer)
      res = HTTParty.get("https://api.giphy.com/v1/gifs/search?api_key=#{ENV["GIPHY_KEY"]}&q=#{name}&rating=g")
      body = JSON.parse(res.body)
      url = body["data"][0]["url"]

      render json: { "id": id, "name": name, "types": types, "url": url }
    else
      render json: { "message": "invalid parameter input" }
    end
  end
  def index
    render json: { "message": "double ok" }
  end
end
