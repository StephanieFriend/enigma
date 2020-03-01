class Shift

  def self.transform_key(key)
    key.split.reduce({}) do |acc, key_index|
      acc[:A] = key_index[0] + key_index[1]
      acc[:B] = key_index[1] + key_index[2]
      acc[:C] = key_index[2] + key_index[3]
      acc[:D] = key_index[3] + key_index[4]
      acc
    end
  end

  def self.transform_date(date)
    date_index = (date.delete("/").to_i ** 2).digits.pop(4)
    date_index.reduce({}) do |acc, _index|
      acc[:A] = date_index[0]
      acc[:B] = date_index[1]
      acc[:C] = date_index[2]
      acc[:D] = date_index[3]
      acc
    end
  end

  def self.final_shift_key(key, date)
    final_shifts = {}
    transform_key(key.to_s.rjust(5, "0")).map do |shift_positions, shift_amount|
      total_moves = transform_date(date)[shift_positions]
      if total_moves != nil
        final_shifts[shift_positions] = shift_amount.to_i + total_moves.to_i
      end
    end
    final_shifts.values
  end
end