# frozen_string_literal: true

require_relative 'dictionary_loader'
require_relative 'dictionary'
require_relative 'dictionary_searcher'
require_relative 'results_saver'

class DictionaryUI
  def initialize
    @diccionary = DictionaryLoader.new(ask_path)
  end

  def ask_path
    puts "Is your dictionary called '5desk.txt'? (Y / N)"
    if gets.chomp.upcase == 'Y'
      '5desk.txt'
    else
      other_path
    end
  end

  def other_path
    puts "So what's the path then?"
    loop do
      @path = gets.chomp
      break if File.exist?(@path)
      puts "File doesn't exist! Enter a new file:"
    end
    @path
  end

  def stats
    puts 'Dictionary successfully loaded' unless @diccionary.display.nil?
    puts "Your dictionary contains #{@diccionary.display.size} words."
    puts 'Word frequency by starting letter:'
    count_words
  end

  def count_words
    @alphabet = Hash.new(0)
    ('A'..'Z').each do |letter|
      @diccionary.display.each do |word|
        @alphabet[letter] += 1 if word[0].upcase == letter
      end
    end
    @alphabet.each do |letter, count|
      puts "#{letter}: #{count}"
    end
  end
end

d = DictionaryUI.new
d.stats
# d.run
