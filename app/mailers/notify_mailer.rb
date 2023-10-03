class NotifyMailer < GovukNotifyRails::Mailer

  def ask_for_help_email(form)
    set_template(ENV.fetch('NOTIFY_TECHNICAL_FORM', nil))
    set_personalisation(
      form_name: form.name,
      reply_to: form.email,
      form_description: form.description
    )
    mail(to: Settings.mail.help_me)
  end

end
