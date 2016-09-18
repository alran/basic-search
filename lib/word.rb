class Word

  attr_accessor :text

  def initialize()
    @text = ''
  end

  def is_word(words)
    words.include?(text)
  end
end
