class Workshop
  include MongoMapper::Document

  key :name,				String
  key :description,			Text
  key :date,				Time
  key :venue,				Text

  one :form_coach
  one :form_participant
  
  timestamps!
end
