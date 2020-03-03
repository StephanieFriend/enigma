require 'date'
require_relative 'shift'

class Enigma

  def encrypt(message, key = rand(10 ** 5).to_s.rjust(5, "0"), date = DateTime.now.strftime("%d%m%y"))
    {
        :encryption => join_message(split_message(message), Shift.final_shift_key(key, date), is_encrypt = true),
        :key => key,
        :date => date
    }
  end

  def decrypt(ciphertext, key = rand(10 ** 5).to_s.rjust(5, "0"), date = DateTime.now.strftime("%d%m%y"))
    {
        :decryption => join_message(split_message(ciphertext), Shift.final_shift_key(key, date), is_encrypt = false),
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

  def join_message(split_characters, shift_keys, is_encrypt)
    message = []
    split_characters.each do |letter_group|
      letter_group.each_with_index do |character, index|
        if alphabet.include?(character)
          message << (find_new_character(((is_encrypt && shift_keys[index]) ||
              (!is_encrypt && -shift_keys[index])), character))
        else
          message << character
        end
      end
    end
    message.join
  end

  # def crack(ciphertext, date = DateTime.now.strftime("%d%m%y"))
  #   key = '00000'
  #   cracked_message = ciphertext
  #
  #   while decrypt(ciphertext, key, date)[:decryption][-4..-1] != ' end'
  #     key = (key.to_i + 1).to_s.rjust(5, '0')
  #     cracked_message = decrypt(ciphertext, key, date)[:decryption]
  #   end
  #
  #   { decryption: cracked_message, date: date, key: key }
  # end

end