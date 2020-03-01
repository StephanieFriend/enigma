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
end