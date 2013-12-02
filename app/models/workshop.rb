class Workshop
  include MongoMapper::Document

  key :name,				String
  key :description,			String
  key :date,				Date
  key :venue,				String

  one :coach_form
  one :participant_form
  
  timestamps!
end
