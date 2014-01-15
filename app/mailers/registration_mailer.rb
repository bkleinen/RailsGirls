class RegistrationMailer < ActionMailer::Base
	default from: 'railsgirlsmanagement@gmail.com'

	def welcome_email(registration, mail_text)
		print "-------------------welcome_email got called -----------------------"
		participant_email_with_name = "#{registration.firstname} #{registration.lastname} <#{registration.email}>"
		user_mails = []
		User.all.each do |user|
			user_mails.push user.email
		end
		mail(to: participant_email_with_name,
			bcc: user_mails,
			subject: registration.form.workshop.mail_template.subject,
			body: mail_text,
         	content_type: "text")
	end

	def deliver_welcome_email(registration, mail_text)
		print "-------------------deliver_mail got called -----------------------"
		self.welcome_email(registration, mail_text).deliver
	end
	# handle_asynchronously :deliver_welcome_email
end