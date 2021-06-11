class CityMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.city_mailer.welcome.subject
  #
  def city_details(user, city)
    @user = user
    @city = city
    @greeting = "Hi, #{user.username}!"

    mail(to: @user.email, subject: "Info about #{city.name}")
  end
end
