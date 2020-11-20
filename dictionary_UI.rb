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
    puts "Is your dictionary's path = '5desk.txt'? (Y / N)"
    if gets.chomp == 'Y'
      '5desk.txt'
    else
      puts "So what's the path then?"
      gets.chomp
    end
  end
end

d = DictionaryUI.new
# d.run
