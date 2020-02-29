require 'date'

class Dated

  def current_date
    DateTime.now.strftime("%d/%m/%y")
  end

  # def date_input
  #   gets.chomp
  # end

  def transform_date(date)
    x = (date.delete("/").to_i ** 2).digits.pop(4)
    x.reduce({}) do |acc, y|
      acc[:A] = x[0]
      acc[:B] = x[1]
      acc[:C] = x[2]
      acc[:D] = x[3]
      acc
    end
  end
end