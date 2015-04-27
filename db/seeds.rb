require 'httparty'

# make mortal kombat, id #1
Request.create	name: 'mortal kombat',
								length: HTTParty.get("http://en.wikipedia.org/w/api.php?format=json&action=query&titles=Mortal%20Kombat&prop=revisions&rvprop=content").parsed_response.to_json.length,
								longer_than_mk: 0,
								searches: 1

# make a dummy entry, US constitution
Request.create 	name: "united states constitution", 
								length: HTTParty.get("http://en.wikipedia.org/w/api.php?format=json&action=query&titles=United%20States%20Constitution&prop=revisions&rvprop=content").parsed_response.to_json.length, 
								longer_than_mk: 1,
								searches: 1 
