class Purchase < ActiveRecord::Base
	belongs_to :prediction
	belongs_to :user
end
