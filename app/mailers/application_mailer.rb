class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('SEND_MAIL', nil)
  layout 'mailer'
end
