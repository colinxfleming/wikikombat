require 'httparty'

# make mortal kombat, id #1
Request.create	name: 'Mortal Kombat',
								length: HTTParty.get("http://en.wikipedia.org/w/api.php?format=json&action=query&titles=Mortal%20Kombat&prop=revisions&rvprop=content").parsed_response.to_json,
								longer_than_mk: 0

# make a dummy entry, US constitution
Request.create 	name: "United States Constitution", 
								length: HTTParty.get("http://en.wikipedia.org/w/api.php?format=json&action=query&titles=United%20States%20Constitution&prop=revisions&rvprop=content").parsed_response.to_json, 
								longer_than_mk: 1 
