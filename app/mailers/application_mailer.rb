class ApplicationMailer < ActionMailer::Base
  default from: 'welcome@nomadworkers.com'
  layout 'mailer'
end
