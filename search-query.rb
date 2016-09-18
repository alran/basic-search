require_relative 'lib/document'

def generate_snippet(document_text, query)
  document = Document.new(document_text)
  document.analyze_sentences(sanitize_query(query))
  document.get_matching_snippets
  document.get_most_relevant_snippet
end

def sanitize_query(query)
  query.downcase.split(' ')
end
