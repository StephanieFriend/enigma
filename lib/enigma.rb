require 'date'
require_relative 'shift'

class Enigma

  def encrypt(message, key = rand(10 ** 5).to_s, date = DateTime.now.strftime("%d%m%y"))
    {
        :encryption => message_encrypt_decrypt(split_message(message), Shift.final_shift_key(key, date), is_encrypt = true),
        :key => key,
        :date => date
    }
  end

  def decrypt(ciphertext, key = rand(10 ** 5).to_s, date = DateTime.now.strftime("%d%m%y"))
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

  def crack(message, date = nil)
    key = 0
    until decrypt(message, key, date)[:decryption][-4..-1] == " end"
      decrypt(message, key, date)[:key]
      key += 1
    end
    decrypt(message, key, date)
  end

  # def crack(message, date = DateTime.now.strftime("%d%m%y"))
  #   key = '00000'
  #   cracked_message = message
  #
  #   while decrypt(message, key, date)[:decryption][-4..-1] != ' end'
  #     key = (key.to_i + 1).to_s.rjust(5, '0')
  #     cracked_message = decrypt(message, key, date)[:decryption]
  #   end
  #
  #   { decryption: cracked_message, date: date, key: key }
  # end

  # def crack(ciphertext, date)
  #   {
  #       :decryption => message_encrypt_decrypt(split_message(ciphertext), Shift.final_shift_key(find_original_key(ciphertext, date), date), is_encrypt = false),
  #       :date => date,
  #       :key => find_original_key(ciphertext, date)
  #   }
  # end

  # def find_original_key(message, date)
  #   num = find_end_key(message, date)
  #   array = num.map do |z|
  #     [z.div(10), z % 10]
  #     end
  #   while array[0][1] != array[1][0]
  #     num[1] = (num[1] + 27) % 100
  #     array[1] = [num[1].div(10), num[1] % 10]
  #   end
  #   while array[1][1] != array[2][0]
  #     num[2] = (num[2] + 27) % 100
  #     array[2] = [num[2].div(10), num[2] % 10]
  #   end
  #   while array[2][1] != array[3][0]
  #     num[3] = (num[3] + 27) % 100
  #     array[3] = [num[3].div(10), num[3] % 10]
  #   end
  #   new_array = []
  #   new_array << array[0][0]
  #   new_array << array[1][0]
  #   new_array << array[2][0]
  #   new_array << array[3][0]
  #   new_array << array[3][1]
  #   new_array.join
  # end

  # def find_original_key2(num)
  #
  #   array = num.map do |z|
  #     [z.div(10), z % 10]
  #   end
  #   while array[0][1] != array[1][0]
  #     num[1] = (num[1] + 27) % 100
  #     array[1] = [num[1].div(10), num[1] % 10]
  #   end
  #   while array[1][1] != array[2][0]
  #     num[2] = (num[2] + 27) % 100
  #     array[2] = [num[2].div(10), num[2] % 10]
  #   end
  #   while array[2][1] != array[3][0]
  #     num[3] = (num[3] + 27) % 100
  #     array[3] = [num[3].div(10), num[3] % 10]
  #   end
  #   new_array = []
  #   new_array << array[0][0]
  #   new_array << array[1][0]
  #   new_array << array[2][0]
  #   new_array << array[3][0]
  #   new_array << array[3][1]
  #   new_array.join
  # end

  # def find_end_key(message, date)
  #   array = []
  #   shift_amount(message).zip(get_offsets(message, date)) do |x, y|
  #     array << x - y
  #   end
  #   array
  # end
  #
  # def get_offsets(message, date)
  #   shifts = Shift.transform_date(date)
  #   order = order_of_shifts(message)
  #   order.map do |key|
  #     shifts[key]
  #   end
  # end
  #
  # def order_of_shifts(message)
  #   x = split_message(message)
  #   y = x.last.length
  #   if y == 4
  #     [:A, :B, :C, :D]
  #   elsif y ==3
  #     [:D, :A, :B, :C]
  #   elsif y == 2
  #     [:C, :D, :A, :B]
  #   else
  #     [:B, :C, :D, :A]
  #   end
  # end
  #
  # def shift_amount(message)
  #   array = []
  #   transform_ciphertext_last_characters(message).zip(transform_end_to_index) do |x, y|
  #     array << ((x - y) < 0 ? (x-y) + 27 : (x-y))
  #   end
  #   array
  # end
  #
  # def transform_ciphertext_last_characters(message)
  #   array = []
  #   x = message[-4..-1].split('')
  #   array << alphabet.find_index(x[0])
  #   array << alphabet.find_index(x[1])
  #   array << alphabet.find_index(x[2])
  #   array << alphabet.find_index(x[3])
  #   array
  # end

  # def transform_end_to_index
  #   array = []
  #   array << alphabet.find_index(" ")
  #   array << alphabet.find_index("e")
  #   array << alphabet.find_index("n")
  #   array << alphabet.find_index("d")
  #   array
  # end

  # def pair(shifts, i, j, first = false)
  #   v1 = shifts[i]
  #   v2 = shifts[j]
  #   s1 = [v1.div(10), v1 % 10]
  #   s2 = [v2.div(10), v2 % 10]
  #   while s1[1] != s2[0]
  #     if v1 < v2 && first
  #       v1 = (v1+27) % (27*3)
  #       s1 = [v1.div(10), v1 % 10]
  #       p "v1 #{v1}"
  #     else
  #       v2 = (v2 +27) % (27*3)
  #       s2 = [v2.div(10), v2 % 10]
  #       p "v2 #{v2}"
  #     end
  #   end
  #   shifts[i] = v1
  #   shifts[j] = v2
  #   return shifts
  # end

  # def checkPairs(shifts)
  #   return shifts[0] % 10 == shifts[1].div(10) && shifts[1] % 10 == shifts[2].div(10) &&
  #       shifts[2] % 10 == shifts[3].div(10)
  # end
  #
  # def genKeyStringFromArr(arr)
  #   arr = pair(arr, 0 ,1, true)
  #   arr = pair(arr, 1 ,2, )
  #   arr = pair(arr, 2,3, )
  #   p "finalized arr -> #{arr}"
  #   return [arr[0].to_s.rjust(2, "0"), arr[1] % 10, arr[2] % 10, arr[3] % 10].join("")
  # end

end

# e = Enigma.new
# # s = e.encrypt(" end", "57099", "030320")
# s = e.encrypt(" end")
# p s
# d = s[:date]
# str = s[:encryption]
# sa = e.shift_amount(str) # THIS WORKS
# p "shift amt #{sa}"
#
# ss = str.split("")
# p ss
#
# # ACTUAL CRACK
# ss.each_with_index do |s,i|
#   # p e.alphabet.find_index(ss[i])
#   # p e.alphabet.rotate(e.alphabet.find_index(ss[i]))[0] "
#
#   rev = sa.rotate(i)[0] * -1
#
#   p e.alphabet.rotate(e.alphabet.find_index(ss[i])).rotate(rev)[0]
# end
#
# dO = e.get_offsets(str, d) # ALSO WORKS
# p "offsets #{dO}"
#
# p sa[0]
# p dO[0]
# k = []
# sa.each_with_index do |s, i|
#   k << (sa[i] - dO[i]) # Find Key Portion
# end
# p "key port #{k}"
#
# pk = e.genKeyStringFromArr(k)
# p pk
#
# p "orig key #{e.decrypt(str, s[:key], d)}"
# p "orig key #{e.decrypt(str, pk, d)}"
#
#
#
# # p e.find_original_key(str, d)
# # p e.crack(str, d)