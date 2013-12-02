class Form
  include MongoMapper::Document
  many :registrations, :as => :form

  key :structure,		Array

  belongs_to :workshop
  
  timestamps!

end
