class Form
  include MongoMapper::Document
  many :registrations

  key :structure,		Array

  belongs_to :workshop
  
  timestamps!

end
