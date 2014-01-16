class Registration
  include MongoMapper::Document

  	key :firstname,		String,   :required => true
  	key :lastname,		String,   :required => true
  	key :email,			String,   :required => true

	# validates :firstname,  presence: true, length: { maximum: 50 }
	# validates :lastname,  presence: true, length: { maximum: 50 }
	# VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	# validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
 # 	                   uniqueness: { case_sensitive: false }
	belongs_to :form, :polymorphic => true
end