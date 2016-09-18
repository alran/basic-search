class Sentence

  attr_accessor :text, :search_ranking

  def initialize()
    @text = ''
    @search_ranking = 0
  end

  def update_ranking
    @search_ranking += 1
  end
end
