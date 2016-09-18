require_relative 'sentence'
require_relative 'snippet'

class Document

  attr_reader :document, :sentences, :snippets

  def initialize(document)
    @document = document
    @sentences = {}
    @snippets = []
  end

  def analyze_sentences(query_words)
    sentence_idx, char_idx = 0, 0
    sentence = Sentence.new
    word = ''

    until @document[char_idx] == nil
      character = @document[char_idx]
      sentence.text += character unless sentence.text == '' && character == ' '
      if character =~ /[A-Za-z]/ || character == '-'
        word += character.downcase
      elsif ['.', ';', '!', '?'].include?(character)
        @sentences[sentence_idx] = sentence
        sentence_idx += 1
        sentence = Sentence.new
      elsif character == ' '
        sentence.update_search_ranking if query_words.include?(word)
        word = ''
      end
      char_idx += 1
    end
  end

  def get_most_relevant_snippet
    @snippets.max_by { |snippet| snippet.search_ranking }.text if @snippets.any?
  end

  def get_matching_snippets
    snippet = Snippet.new

    @sentences.each do |index, analysis|
      if analysis.search_ranking > 0
        snippet.last_ranked_index = index
        snippet.add_sentence(analysis)
      elsif nearby_ranked_sentence(snippet, index)
        snippet.add_sentence(analysis)
      elsif snippet.text != ''
        @snippets << snippet
        snippet = Snippet.new
      end
    end
    @snippets << snippet if snippet.text != ''
  end

  private

  def nearby_ranked_sentence(snippet, index)
    index != 0 && previous_sentence_is_ranked(snippet, index) && next_sentence_is_ranked(index)
  end

  def next_sentence_is_ranked(index)
    @sentences[index + 1] ? @sentences[index + 1].search_ranking > 0 : false
  end

  def previous_sentence_is_ranked(snippet, index)
    snippet.last_ranked_index ? snippet.last_ranked_index >= index - 1 : false
  end
end
