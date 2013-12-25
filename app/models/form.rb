class Form
  include MongoMapper::Document
  many :registrations, :as => :form

  key :structure,		Object
  key :template,		Boolean
  belongs_to :workshop
  
  timestamps!

end
