require_relative 'search-query'

describe 'search-query' do
  let(:search_query) { 'designer kitchen' }
  let(:document_text) { 'Our luxury loft-style apartments were constructed as condominiums, so your new residence will have: Solid floors and walls (this will be the quietest apartment you\'ve EVER lived in); Premium stainless steel designer appliances; Distinctive accent walls and hardwood flooring; A kitchen that most chefs would drool over with easy to clean gas stove and countertops; Walk in closets with built in storage; Full size washer and dryer in each apartment home. In addition, all residents will enjoy use of our top-notch amenities, including reserved parking, cutting-edge fitness center, wireless internet cafe/business center, and rooftop lounge to soak up the sun!' }

  context 'generate_snippet' do
    let(:snippet) { generate_snippet(document_text, search_query) }

    it 'returns a string' do
      expect(snippet).to be_kind_of String
    end

    it 'returns the most relevant snippet' do
      most_relevant_snippet = 'Premium stainless steel designer appliances; Distinctive accent walls and hardwood flooring; A kitchen that most chefs would drool over with easy to clean gas stove and countertops; '
      expect(snippet).to eq most_relevant_snippet
    end
  end

  context 'sanitize_query' do
    let(:sanitized_query) { sanitize_query(search_query) }

    it 'returns an array' do
      expect(sanitized_query).to be_kind_of Array
    end

    it 'makes all words lowercase' do
      first_letters = sanitized_query.map { |word| word.downcase }
      expect(first_letters).to eq sanitized_query
    end

    it 'returns the correct number of words' do
      words = search_query.split(' ').count
      expect(words).to eq sanitized_query.count
    end
  end

  describe Document do
    let(:document) { Document.new(document_text) }

    context 'analyze_sentences' do
      it 'separates the document into the correct number of sentences' do
        document.analyze_sentences(search_query)
        expect(document.sentences.length).to eq 7
      end
    end

    context 'get_matching_snippets' do
      it 'finds the correct number of snippets' do
        document.analyze_sentences(search_query)
        document.get_matching_snippets
        expect(document.snippets.length).to eq 1
      end
    end

    context 'get_most_relevant_snippet' do
      it 'returns a string if there are relevant snippets' do
        document.analyze_sentences(search_query)
        document.get_matching_snippets
        expect(document.get_most_relevant_snippet).to be_kind_of String
      end

      it 'returns nil if no relevant snippets were found' do
        expect(document.get_most_relevant_snippet).to be nil
      end
    end
  end

  describe Sentence do
    let(:sentence) { Sentence.new() }

    context 'update_ranking' do
      it 'stores words and increases search ranking' do
        sentence.update_ranking('hello')
        expect(sentence.matching_words.length).to eq 1
        expect(sentence.search_ranking).to eq 1
      end
    end
  end

  describe Word do
    let(:word) { Word.new() }

    context 'is_word' do
      let(:words) { ['hello', 'goodbye'] }

      it 'returns a boolean' do
        expect(word.is_word(words)).to be(true).or be(false)
      end

      it 'returns false when the argument does not contain the word text' do
        word.text = 'whatever'
        expect(word.is_word(words)).to be false
      end

      it 'returns true when the word text is the same as the argument' do
        word.text = 'hello'
        expect(word.is_word(words)).to be true
      end
    end
  end

  describe Snippet do
    let(:snippet) { Snippet.new() }

    context 'add_sentence' do
      it 'updates the snippet text with spacing and search_ranking' do
        sentence = Sentence.new()
        sentence.text = 'the big yellow house'
        sentence.search_ranking = 1
        snippet.add_sentence(sentence)
        expect(snippet.search_ranking).to eq 1
        expect(snippet.text).to eq 'the big yellow house '
      end
    end
  end
end
