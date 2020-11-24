# frozen_string_literal: true

class ResultsSaver
  def initialize(path, search_term, search)
    @search_term = search_term
    @search = search
    @path = path
  end

  def write
    File.open(@path,'w') do |file|
      file.write "You searched for #{@search_term}\n"
      file.write @search
    end
  end
end