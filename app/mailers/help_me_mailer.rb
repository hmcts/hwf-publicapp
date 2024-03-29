class HelpMeMailer < ActionMailer::Base
  def ask_for_help_email(form)
    mail(to: Settings.mail.help_me,
         from: form.email,
         subject: "[Ask-for-Help] #{form.name} has requested technical assistance",
         content_type: "text/plain",
         body: form.description)
  end
end
