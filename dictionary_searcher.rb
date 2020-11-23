# frozen_string_literal: true

require 'pry'

class DictionarySearcher

  def initialize(dictionary, search)
    @dictionary = dictionary
    @search = Regexp.new search
  end

  def search
    @dictionary.select { |w| w =~ @search }
  end
end
