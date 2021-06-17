module TempHelper
  def summer_average(city)
    arr = get_temps(city)
    city.latitude >= 0 ? arr[5, 3].sum / 3 : (arr[0, 2].sum + arr[-2]) / 3
  end

  def winter_average(city)
    arr = get_temps(city)
    city.latitude >= 0 ? (arr[0, 2].sum + arr[-2]) / 3 : arr[5, 3].sum / 3
  end

  private

  def get_temps(city)
    city.weather['temp']
  end
end
