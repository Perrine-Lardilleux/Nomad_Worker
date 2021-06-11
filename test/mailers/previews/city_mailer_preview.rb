# Preview all emails at http://localhost:3000/rails/mailers/city_mailer
class CityMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/city_mailer/welcome
  def welcome
    CityMailer.welcome
  end

end
