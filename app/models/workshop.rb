class Workshop < ActiveRecord::Base
	belongs_to :participant_form, :class_name => "Form"
	belongs_to :coach_form, :class_name => "Form"
end
