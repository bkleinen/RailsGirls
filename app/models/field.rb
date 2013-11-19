class Field < ActiveRecord::Base
	belongs_to :registration
	belongs_to :metafield
end
