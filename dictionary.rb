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
end
