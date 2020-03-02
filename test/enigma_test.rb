require 'test_helper'
require './lib/enigma'

class EnigmaTest < Minitest::Test

  def test_it_exists
    enigma = Enigma.new

    assert_instance_of Enigma, enigma
  end

  def test_it_can_generate_a_random_key
    enigma = Enigma.new

    key = rand(10 ** 5).to_s
    enigma.encrypt("Hello world", key, "290220")

    assert_instance_of String, key
    assert_equal 5, key.length
  end

  def test_it_can_generate_current_date
    enigma = Enigma.new

    DateTime.stubs(:now).returns(DateTime.new(2020, 2, 29))

    date =  DateTime.now.strftime("%d/%m/%y")
    enigma.encrypt("Hello world", "12345", date)

    assert_equal "29/02/20", date
  end

  def test_it_can_encrypt
    enigma = Enigma.new

    message = "Hello world!"
    key = "12345"
    date = "290220"

    expected = {
        :encryption => "vcwkbygnejo!",
        :key => "12345",
        :date => "290220"
    }

    assert_equal expected, enigma.encrypt(message, key, date)
  end

  def test_it_can_decrypt
    enigma = Enigma.new

    ciphertext = "vcwkbygnejo!"
    key = "12345"
    date = "290220"

    expected = {
        :decryption => "hello world!",
        :key => "12345",
        :date => "290220"
    }

    assert_equal expected, enigma.decrypt(ciphertext, key, date)
  end

  def test_it_can_produce_a_27_character_alphabet
    enigma = Enigma.new

    assert_instance_of Array, enigma.alphabet
    assert_equal 27, enigma.alphabet.length
    assert_equal " ", enigma.alphabet.last
  end

  def test_it_can_split_a_message
    enigma = Enigma.new

    message = "hello world!"

    expected = [["h", "e", "l", "l"], ["o", " ", "w", "o"], ["r", "l", "d", "!"]]

    assert_equal expected, enigma.split_message(message)
  end

  def test_it_can_find_new_character
    enigma = Enigma.new

    assert_equal "e", enigma.find_new_character(1, "d")
    assert_equal "c", enigma.find_new_character(-1, "d")
  end

  def test_it_can_encrypt_or_decrypt_message
    enigma = Enigma.new

    split_characters1 = [["h", "e", "l", "l"], ["o", " ", "w", "o"], ["r", "l", "d", "!"]]
    shift_keys1 = [14, 25, 38, 53]
    is_encrypt1 = true

    assert_equal "vcwkbygnejo!", enigma.message_encrypt_decrypt(split_characters1, shift_keys1, is_encrypt1)

    split_characters2 = [["v", "c", "w", "k"], ["b", "y", "g", "n"], ["e", "j", "o", "!"]]
    shift_keys2 = [14, 25, 38, 53]
    is_encrypt2 = false

    assert_equal "hello world!", enigma.message_encrypt_decrypt(split_characters2, shift_keys2, is_encrypt2)
  end

  def test_it_can_crack
    enigma = Enigma.new

    expected = {
        :decryption => "hello world! end",
        :date => "290220",
        :key => "12345"
    }

    assert_equal expected, enigma.crack("vcwkbygnejo!ncyc", "290220")
  end

  def test_it_can_find_offset
    enigma = Enigma.new

    assert_equal [8, 2, 2, 4], enigma.get_offsets("vcwkbygnejo", "290220")
  end

  def test_it_can_find_order_of_shifts
    enigma = Enigma.new

    message1 = "vcwkbygnejo!ncyc"
    message2 = "vcwkbygnejo"
    message3 = "vcwkb"

    assert_equal [:A, :B, :C, :D], enigma.order_of_shifts(message1)
    assert_equal [:D, :A, :B, :C], enigma.order_of_shifts(message2)
    assert_equal [:B, :C, :D, :A], enigma.order_of_shifts(message3)
  end

  def test_it_can_determine_shift_amount
    enigma = Enigma.new

    assert_equal [14, 25, 11, 26], enigma.shift_amount("vcwkbygnejo!ncyc")
  end

  def test_it_can_find_index_number_of_ciphertext
    enigma = Enigma.new

    assert_equal [13, 2, 24, 2], enigma.transform_ciphertext_last_characters("vcwkbygnejo!ncyc")
  end

  def test_it_can_transform_end_to_index
    enigma = Enigma.new

    assert_equal [26, 4, 13, 3], enigma.transform_end_to_index
  end
end