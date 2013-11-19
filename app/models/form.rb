class Form < ActiveRecord::Base
	has_one :workshop
	has_many :registrations
	has_many :metafields
end
