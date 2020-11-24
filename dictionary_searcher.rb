# frozen_string_literal: true

require 'pry'

class DictionarySearcher
  def initialize(dictionary, choice, search)
    @dictionary = dictionary
    @choice = choice
    @search = search
  end

  def search
    case @choice
    when 1 then search_total
    when 2 then search_parcial
    when 3 then search_beginning
    when 4 then search_end
    end
  end

  def search_total
    @search_regex = /\b#{Regexp.quote(@search)}\b/
    @dictionary.grep(@search_regex)
  end

  def search_parcial
    @search_regex = /#{Regexp.quote(@search)}/
    @dictionary.grep(@search_regex)
  end

  def search_beginning
    @search_regex = /\b#{Regexp.quote(@search)}/
    @dictionary.grep(@search_regex)
  end

  def search_end
    @search_regex = /#{Regexp.quote(@search)}\b/
    @dictionary.grep(@search_regex)
  end
end
