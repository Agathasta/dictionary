# frozen_string_literal: true

class DictionaryLoader
  def initialize(path)
    @path = path
    load_diccionary
  end

  def load_diccionary
    @file = begin
      File.readlines(@path)
    rescue StandardError
      exit
    end
  end

  def display
    @diccionary = []
    @file.each { |line| @diccionary << line.strip }
    @diccionary
  end
end
