class Shift

  def self.transform_key(key)
    key.split.reduce({}) do |acc, k|
      acc[:A] = k[0] + k[1]
      acc[:B] = k[1] + k[2]
      acc[:C] = k[2] + k[3]
      acc[:D] = k[3] + k[4]
      acc
    end
  end

  def self.transform_date(date)
    x = (date.delete("/").to_i ** 2).digits.pop(4)
    x.reduce({}) do |acc, y|
      acc[:A] = x[0]
      acc[:B] = x[1]
      acc[:C] = x[2]
      acc[:D] = x[3]
      acc
    end
  end

  def self.final_shift_key(key, date)
    hash = {}
    transform_key(key.to_s.rjust(5, "0")).map do |keys, value|
      total = transform_date(date)[keys]
      if total != nil
        hash[keys] = value.to_i + total.to_i
      end
    end
    hash.values
  end
end