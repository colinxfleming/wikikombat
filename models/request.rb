class Request < ActiveRecord::Base
	validates :name, :length, :words, :grade_level, presence: true
end