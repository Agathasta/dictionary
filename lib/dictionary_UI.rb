# frozen_string_literal: true

require_relative 'dictionary_loader'
require_relative 'dictionary'
require_relative 'dictionary_searcher'
require_relative 'results_saver'

class DictionaryUI
  def initialize
    loader = DictionaryLoader.new(ask_path)
    @dictionary = Dictionary.new(loader.file)
  end

  def ask_path
    puts `clear`
    puts "\e[35mIs the dictionary you want to use called '5desk.txt'? (Y / N)\e[0m"
    puts "\e[37m(say Yes unless you have a long list of words in txt.format and know the path to it)\e[0m"
    print "\e[35m> \e[0m"
    gets.chomp.upcase == 'Y' ? '5desk.txt' : other_path
  end

  def other_path
    puts "\e[35mSo what's the path then? (q to quit)\e[0m"
    print "\e[35m> \e[0m"
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
    puts "\e[34mDictionary successfully loaded\e[0m" unless @dictionary.display.empty?
    puts "\n\e[35mShow statistics? (Y / N)\e[0m"
    print "\e[35m> \e[0m"
    if gets.chomp.upcase == 'Y'
      puts "\e[34mWord frequency by starting letter:\e[0m"
      @dictionary.count_words
      puts "\e[34mYour dictionary contains #{@dictionary.display.size} words.\e[0m"
      puts
    end
  end

  def search
    search_choice
    search_term
    results
  end

  def search_choice
    puts "\e[35mWhat kind of search do you want to make?\e[0m"
    puts '# 1: Exact'
    puts '# 2: Partial'
    puts '# 3: Begins With'
    puts '# 4: Ends With'
    print "\e[35m> \e[0m"
    loop do
      @choice = gets.chomp
      exit if @choice.upcase == 'Q'
      break if (1..4).include? @choice.to_i

      puts 'Wrong choice! Choose a number from 1 to 4 (or q to quit):'
      print "\e[35m> \e[0m"
    end
  end

  def search_term
    puts "\e[35mEnter the search term:\e[0m"
    print "\e[35m> \e[0m"
    @search_term = gets.chomp.downcase
    @search = DictionarySearcher.new(@dictionary.display, @choice.to_i, @search_term)
  end

  def results
    puts "\e[34mResults:\e[0m"
    puts @search.search
    puts "\e[34m#{@search.search.size} words found\e[0m"
  end

  def save
    puts "\n\e[35mDo you want to save the results? (Y / N)\e[0m"
    print "\e[35m> \e[0m"
    exit if gets.chomp.upcase == 'N'
    filepath
    save_file
  end

  def filepath
    puts "\e[35mWhat filepath should we write results to? (.txt)\e[0m"
    print "\e[35m> \e[0m"
    @path = gets.chomp
    if File.exist?(@path)
      puts "\e[35mThat file exists, overwrite? (Y / N)\e[0m"
      print "\e[35m> \e[0m"
      exit if gets.chomp.upcase == 'N'
    end
  end

  def save_file
    @saved_results = ResultsSaver.new(@path, @search_term, @search.search)
    @saved_results.write
    puts "\e[34mFile successfully written!\e[0m"
  end
end

d = DictionaryUI.new
d.stats
d.search
d.save
