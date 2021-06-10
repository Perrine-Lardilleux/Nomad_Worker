ActionMailer::Base.smtp_settings = {
  address: "smtp.gmail.com",
  port: 587,
  domain: 'gmail.com',
  user_name: ENV['nomad.worker.perrine@gmail.com'],
  password: ENV['xbsnajdpvwghsozw'],
  authentication: :login,
  enable_starttls_auto: true
}
