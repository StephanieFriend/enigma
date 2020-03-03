require 'date'
require_relative 'shift'

class Enigma

  def encrypt(message, key = rand(10 ** 5).to_s, date = DateTime.now.strftime("%d/%m/%y"))
    {
        :encryption => message_encrypt_decrypt(split_message(message), Shift.final_shift_key(key, date), is_encrypt = true),
        :key => key,
        :date => date
    }
  end

  def decrypt(ciphertext, key = rand(10 ** 5).to_s, date = DateTime.now.strftime("%d/%m/%y"))
    {
        :decryption => message_encrypt_decrypt(split_message(ciphertext), Shift.final_shift_key(key, date), is_encrypt = false),
        :key => key,
        :date => date
    }
  end

  def alphabet
    ("a".."z").to_a << " "
  end

  def split_message(message)
    split_characters = []
    message.downcase.chars.each_slice(4) do |character_group|
      split_characters << character_group
    end
    split_characters
  end

  def find_new_character(shift_amount, letter_index)
    alphabet.rotate(shift_amount)[alphabet.find_index(letter_index)]
  end

  def message_encrypt_decrypt(split_characters, shift_keys, is_encrypt)
    message = []
    split_characters.each do |group|
      group.each_with_index do |char, index |
        if alphabet.include?(char)
          message << (find_new_character(((is_encrypt && shift_keys[index]) || (!is_encrypt && -shift_keys[index])), char))
        else
          message << char
        end
      end
    end
    message.join
  end

  def crack(ciphertext, date)
    shift_amount(ciphertext)
    get_offsets(ciphertext, date)
  end

  def find_original_key(message, date)
    array = find_end_key(message, date)
    while array[0][1] != array[1][0]
      x = array[1].to_i
      x += 27
      array[1] = x.to_s
    end
    while array[1][1] != array[2][0]
      y = array[2].to_i
      y += 27
      array[2] = y.to_s
    end
    while array[2][1] != array[3][0]
      z = array[3].to_i
      z += 27
      array[3] = z.to_s
    end
    new_array = []
    new_array << array[0][0]
    new_array << array[1][0]
    new_array << array[2][0]
    new_array << array[3][0]
    new_array << array[3][1]
    new_array.join
  end

  def find_end_key(message, date)
    array = []
    shift_amount(message).zip(get_offsets(message, date)) do |x, y|
      array << (x - y).to_s.rjust(2, "0")
    end
    array
  end

  def get_offsets(message, date)
    shifts = Shift.transform_date(date)
    order = order_of_shifts(message)
    order.map do |key|
      shifts[key]
    end
  end

  def order_of_shifts(message)
    x = split_message(message)
    y = x.last.length
    if y == 4
      [:A, :B, :C, :D]
    elsif y ==3
      [:D, :A, :B, :C]
    elsif y == 2
      [:C, :D, :A, :B]
    else
      [:B, :C, :D, :A]
    end
  end

  def shift_amount(message)
    array = []
    transform_ciphertext_last_characters(message).zip(transform_end_to_index) do |x, y|
      z = x - y
      if z < 0
        z += 27
      end
      array << z
    end
    array
  end

  def transform_ciphertext_last_characters(message)
    array = []
    x = message[-4..-1].split('')
    array << alphabet.find_index(x[0])
    array << alphabet.find_index(x[1])
    array << alphabet.find_index(x[2])
    array << alphabet.find_index(x[3])
    array
  end

  def transform_end_to_index
    array = []
    array << alphabet.find_index(" ")
    array << alphabet.find_index("e")
    array << alphabet.find_index("n")
    array << alphabet.find_index("d")
    array
  end

end