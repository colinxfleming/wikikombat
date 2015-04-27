class Request < ActiveRecord::Base
	validates :name, :length, :searches, presence: true

	validates :name, uniqueness: true

end