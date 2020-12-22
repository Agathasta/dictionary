# frozen_string_literal: true

require_relative 'dictionary_loader'
require_relative 'dictionary'
require_relative 'dictionary_searcher'
require_relative 'results_saver'
require_relative 'color'

class DictionaryUI
  def initialize
    loader = DictionaryLoader.new(ask_path)
    @dictionary = Dictionary.new(loader.file)
  end

  def ask_path
    puts `clear`
    puts "Is the dictionary you want to use called '5desk.txt'? (Y / N)".magenta
    puts "(say Yes unless you have a long list of words in txt.format and know the path to it).".white
    print "> ".magenta
    gets.chomp.upcase == 'Y' ? '5desk.txt' : other_path
  end

  def other_path
    puts "So what's the path then? (q to quit)".magenta
    print "> ".magenta
    loop do
      @path = gets.chomp
      exit if @path.upcase == 'Q'
      break if File.exist?(@path)

      puts "File doesn't exist! Enter a new file: (q to quit)"
      print '> '
    end
    @path
  end

  def stats
    puts "Dictionary successfully loaded".blue unless @dictionary.display.empty?
    puts "Show statistics? (Y / N)".magenta
    print "> ".magenta
    if gets.chomp.upcase == 'Y'
      puts "Word frequency by starting letter:".blue
      @dictionary.count_words
      puts "Your dictionary contains #{@dictionary.display.size} words.".blue
      puts
    end
  end

  def search
    search_choice
    search_term
    results
  end

  def search_choice
    puts "What kind of search do you want to make?".magenta
    puts '# 1: Exact'
    puts '# 2: Partial'
    puts '# 3: Begins With'
    puts '# 4: Ends With'
    print "> ".magenta
    loop do
      @choice = gets.chomp
      exit if @choice.upcase == 'Q'
      break if (1..4).include? @choice.to_i

      puts 'Wrong choice! Choose a number from 1 to 4 (or q to quit):'
      print "> ".magenta
    end
  end

  def search_term
    puts "Enter the search term:".magenta
    print "> ".magenta
    @search_term = gets.chomp.downcase
    @search = DictionarySearcher.new(@dictionary.display, @choice.to_i, @search_term)
  end

  def results
    puts "Results:".blue
    puts @search.search
    puts "#{@search.search.size} words found".blue
  end

  def save
    puts "Do you want to save the results? (Y / N)".magenta
    print "> ".magenta
    exit if gets.chomp.upcase == 'N'
    filepath
    save_file
  end

  def filepath
    puts "What filepath should we write results to? (.txt)".magenta
    print "> ".magenta
    @path = gets.chomp
    if File.exist?(@path)
      puts "That file exists, overwrite? (Y / N)".magenta
      print "> ".magenta
      exit if gets.chomp.upcase == 'N'
    end
  end

  def save_file
    @saved_results = ResultsSaver.new(@path, @search_term, @search.search)
    @saved_results.write
    puts "File successfully written!".blue
  end
end

d = DictionaryUI.new
d.stats
d.search
d.save
