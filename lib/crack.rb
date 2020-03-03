require_relative 'enigma'

enigma = Enigma.new

file =  File.open(ARGV[0], "r")

new_text = file.read.chomp

file.close

cracked_message = enigma.crack(new_text, *ARGV[2..3])

new_file = File.open(ARGV[1], "w")

new_file.write(cracked_message[:decryption])

new_file.close

p "Created #{ARGV[1]} with the key #{cracked_message[:key]} and date #{cracked_message[:date]}"
