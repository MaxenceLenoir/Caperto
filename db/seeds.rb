require 'net/http'
require 'json'

Capital.destroy_all

uri = URI('https://raw.githubusercontent.com/Ginden/capitals/master/europe.json')
res = Net::HTTP.get_response(uri)
JSON.parse(res.body).each do |data|
  Capital.create(
    name: data["properties"]["capital"],
    country: data["properties"]["country"],
    longitude: data["geometry"]["coordinates"][0],
    latitude: data["geometry"]["coordinates"][1]
  )
end
