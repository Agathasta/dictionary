# frozen_string_literal: true

class Dictionary
  def initialize(file)
    @file = file
  end

  def display
    @dictionary = []
    @file.each { |line| @dictionary << line.strip.downcase }
    @dictionary
  end

  def count_words
    @alphabet = Hash.new(0)
    ('A'..'Z').each do |letter|
      @dictionary.each do |word|
        @alphabet[letter] += 1 if word[0].upcase == letter
      end
    end
    @alphabet.each do |letter, count|
      puts "#{letter}: #{count}"
    end
  end
end
