class Registration
  include MongoMapper::Document

	key :firstname,		String,   :length => { :maximum => 50 }
	key :lastname,		String,   :length => { :maximum => 50 }
	key :email,			String

	validates_presence_of :firstname, :lastname, :email
	# validate :custom_validation

	def custom_validation
		email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	    if validates_format_of :email, :with =>email_regex
	      errors.add( :email, "Incorrect Email")
	    end
	end
	belongs_to :form, :polymorphic => true
end