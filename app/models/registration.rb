class Registration < ActiveRecord::Base
	belongs_to :form
	has_many :fields
end
