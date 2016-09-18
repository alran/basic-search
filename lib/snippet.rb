class Snippet

  attr_accessor :last_ranked_index
  attr_reader :search_ranking, :text

  def initialize()
    @text = ''
    @last_ranked_index = 0
    @search_ranking = 0
  end

  def add_sentence(analysis)
    @text += analysis.text + ' '
    @search_ranking += analysis.search_ranking
  end
end
