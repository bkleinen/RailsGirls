class Workshop < ActiveRecord::Base
	belongs_to :participant_form, :class_name => "Form", :associative_foreign_key => "participant_form_id"
	belongs_to :coach_form, :class_name => "Form", :associative_foreign_key => "coach_form_id"
end
