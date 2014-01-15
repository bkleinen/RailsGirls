class Workshop
  include MongoMapper::Document
  plugin MongoMapper::Plugins::MultiParameterAttributes

  key :name,				String
  key :description,			String
  key :date,				Date
  key :venue,				String
  key :status,				String

  one :mail_template
  one :coach_form
  one :participant_form
  
  timestamps!
end
