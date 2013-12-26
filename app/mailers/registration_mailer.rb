# class RegistrationMailer < ActionMailer::Base
# 	default from: 'notifications@example.com' 
	
# 	def welcome_email(registration)
# 	    @registration = registration
# 	    workshop_id = Form.find(registration.form_id).workshop_id
# 		@workshop = Workshop.find(workshop_id)
# 		email_with_name = "#{@registration.name} <#{@registration.email}>"
# 		mail(to: email_with_name, subject: 'Thank you for registering at the Ruby on Rails Workshop')
# 	end

# end