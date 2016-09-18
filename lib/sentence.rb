class Sentence

  attr_accessor :text, :search_ranking
  attr_reader :document_index, :matching_words

  def initialize(document_index)
    @text = ''
    @matching_words = []
    @search_ranking = 0
    @document_index = document_index
  end

  def update_ranking(word)
    @matching_words << word
    @search_ranking += 1
  end
end
