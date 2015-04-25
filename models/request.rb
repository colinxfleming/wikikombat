class Request < ActiveRecord::Base
	validates :name, :length, presence: true

end