class RegistrationMailer < ActionMailer::Base
	default from: 'railsgirlsmanagement@gmail.com'

	def welcome_email(registration, mail_text)
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

	def manual_email(mail_details)
		participant_email_with_name = "Rails Girls <railsgirlsmanagement@gmail.com>"
		receipments = []
		if mail_details[:admin]
			User.all.each do |user|
				receipments.push user.email
			end
		end
		if mail_details[:participants]
			Registration.all.each do |registration|
				if registration.form_type == "ParticipantForm"
					receipments.push registration.email
				end
			end
		end
		if mail_details[:coach]
			Registration.all.each do |registration|
				if registration.form_type == "CoachForm"
					receipments.push registration.email
				end
			end
		end
		mail_text = mail_details[:text]
		if mail_details[:text]
			workshop = Workshop.find(mail_details[:workshop][:id])
			pseudo_tags = {
				"[workshop_name]" => workshop.name,
				"[workshop_description]" => workshop.description,
				"[workshop_date]" => workshop.date.to_s,
				"[workshop_venue]" => workshop.venue
			}
			pseudo_tags.each do |key, value|
				mail_text.gsub! key, value
			end
		end
		mail(to: participant_email_with_name,
			bcc: receipments,
			subject: mail_details[:subject],
			body: mail_text,
         	content_type: "text")
	end
end