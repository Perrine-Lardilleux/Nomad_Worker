module TempHelper
  def temp_average(city, season)
    arr = city.weather['temp']
    mid_year = (arr[5, 3].sum / 3).round(1)
    end_year = ((arr[0, 2].sum + arr[-2]) / 3).round(1)
    if city.latitude >= 0 && season == 'summer'
      mid_year
    elsif city.latitude >= 0 || season == 'summer'
      end_year
    else
      mid_year
    end
  end
end
