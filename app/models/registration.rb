class Registration < ActiveRecord::Base
	before_save { self.email = email.downcase }
	validates :firstname,  presence: true, length: { maximum: 50 }
	validates :lastname,  presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

    validates :language, :last_attended, :coding_level, :os, :other_languages, :join_group, presence: true

 	def self.inherited(child)
	  child.instance_eval do
	    def model_name
	      Registration.model_name
	    end
	  end
	  super
	end
end