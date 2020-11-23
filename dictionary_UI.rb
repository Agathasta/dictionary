# frozen_string_literal: true

require 'pry'

require_relative 'dictionary_loader'
require_relative 'dictionary'
require_relative 'dictionary_searcher'
require_relative 'results_saver'

class DictionaryUI
  attr_reader :dictionary

  def initialize
    loader = DictionaryLoader.new(ask_path)
    @dictionary = Dictionary.new(loader.file)
  end

  def ask_path
    puts "Is your dictionary called '5desk.txt'? (Y / N, q to quit)"
    answer = gets.chomp
    if answer.upcase == 'Y'
      '5desk.txt'
    elsif answer.upcase == 'Q'
      exit
    else
      other_path
    end
  end

  def other_path
    puts "So what's the path then? (q to quit)"
    loop do
      @path = gets.chomp
      exit if @path.upcase == 'Q'
      break if File.exist?(@path)
      puts "File doesn't exist! Enter a new file: (q to quit)"
    end
    @path
  end

  def stats
    puts 'Dictionary successfully loaded' unless @dictionary.display.nil?
    puts "Your dictionary contains #{@dictionary.display.size} words."
    puts 'Word frequency by starting letter:'
    @dictionary.count_words
  end

  def search
    puts "Write"
    search = gets.chomp.downcase
    searching = DictionarySearcher.new(@dictionary.display, search)
    puts searching.search
  end
end

d = DictionaryUI.new
d.stats
d.search
# d.run
