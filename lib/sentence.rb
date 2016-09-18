class Sentence

  attr_accessor :text, :search_ranking
  attr_reader :matching_words

  def initialize()
    @text = ''
    @matching_words = []
    @search_ranking = 0
  end

  def update_ranking(word)
    @matching_words << word
    @search_ranking += 1
  end
end
