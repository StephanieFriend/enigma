class Key

  def generate_random_key
    rand(10 ** 5).to_s
  end

  def key_input(user_key)
    # gets.chomp
    user_key.to_s.rjust(5, "0")
  end

  def transform_key(key)
    key.each_char.map(&:to_i)
  end
end