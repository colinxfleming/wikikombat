class Request < ActiveRecord::Base
	validates :name, :length, :searches, presence: true

end