require_relative 'enigma'

enigma = Enigma.new

file =  File.open(ARGV[0], "r")

new_text = file.read.chomp

file.close

decrypted_message = enigma.decrypt(new_text, *ARGV[2..3])

new_file = File.open(ARGV[1], "w")

new_file.write(decrypted_message[:decryption])

new_file.close

p "Created #{ARGV[1]} with the key #{decrypted_message[:key]} and date #{decrypted_message[:date]}"
