# frozen_string_literal: true

class DictionaryLoader
  attr_reader :file

  def initialize(path)
    @file = File.readlines(path)
  end

end
