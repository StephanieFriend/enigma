# class Key
#
#   def self.generate_random_key
#     rand(10 ** 5).to_s
#   end
#
#   def self.key_input(user_key)
    # gets.chomp
#     user_key.to_s.rjust(5, "0")
#   end
#
#   def self.transform_key(key)
#     key.split.reduce({}) do |acc, k|
#       acc[:A] = k[0] + k[1]
#       acc[:B] = k[1] + k[2]
#       acc[:C] = k[2] + k[3]
#       acc[:D] = k[3] + k[4]
#       acc
#     end
#   end
# end