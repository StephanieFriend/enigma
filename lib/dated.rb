require 'date'

class Dated

  def current_date
    DateTime.now.strftime("%d/%m/%y")
  end

  def date_input
    gets.chomp
  end

  def transform_date(date)
    x = (date.delete("/").to_i ** 2).digits.pop(4)
    x.reduce({}) do |acc, y|
      acc[:A] = y[0]
      acc[:B] = y[1]
      acc[:C] = y[2]
      acc[:D] = y[3]
      acc
    end
  end
end