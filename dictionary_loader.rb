# frozen_string_literal: true

class DictionaryLoader
  def initialize(path)
    @path = path
    load_diccionary
  end

  def load_diccionary
    @diccionary = File.readlines(@path)
  end
end
