class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def float_to_years_and_months(float)
    years = Integer(float)
    decimal_months = float - years
    months =  Integer((decimal_months * 12).round)
    str = "#{pluralize(years, 'year')}"
    str += " and #{pluralize(months, 'month')}" unless months == 0
    str
  end

end
