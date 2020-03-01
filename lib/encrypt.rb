require_relative 'enigma'

enigma = Enigma.new

file =  File.open(ARGV[0], "r")

new_text = file.read.chomp

file.close

encrypted_message = enigma.encrypt(new_text, *ARGV[2..3])

new_file = File.open(ARGV[1], "w")

new_file.write(encrypted_message[:encryption])

new_file.close

p "Created #{ARGV[1]} with the key #{encrypted_message[:key]} and date #{encrypted_message[:date]}"