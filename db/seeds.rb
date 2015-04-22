Request.create 	name: "United States Constitution", 
								length: 100, 
								words: 100, 
								grade_level: 2.3, 
								longer_than_mk: 0, 
								more_words_than_mk: 0, 
								harder_than_mk: 0

for i in 1..4
	Request.create 	name: "Seed Item #{i}", 
									length: rand(1000), 
									words: rand(1000), 
									grade_level: rand(10), 
									longer_than_mk: 1, 
									more_words_than_mk: 1, 
									harder_than_mk: 1
end