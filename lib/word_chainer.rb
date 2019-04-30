require 'set'
class WordChainer
  attr_reader :dictionary

  def initialize
    @dictionary = self.get_dictionary()
    @current_words = []
    @all_seen_words = []
  end

  def run(source, target)
    @current_words = adjacent_words(source)
    @all_seen_words = @current_words.dup

    while !@current_words.empty?
      new_current_words = []
      @current_words.each do |current_word|
        adjacents = adjacent_words(current_word)
        adjacents.each do |adjacent_word|
          next if @all_seen_words.include?(adjacent_word)
          new_current_words << adjacent_word
          @all_seen_words << adjacent_word
        end

      end
      p new_current_words
      @current_words = new_current_words

    end

  end

  def get_dictionary
    dict = Set.new()
    File.open(__dir__ + '/dictionary.txt') do |f|
      f.each_line do |line|
        dict.add(line.strip)
      end
    end
    dict
  end

  def adjacent_words(word)
    alphabet = ('a'..'z').to_a
    adjacents = []
    (0...word.length).each do |i|
      alphabet.each do |letter|
        new_word = word.dup
        new_word[i] = letter
        if @dictionary.include?(new_word) && word != new_word
          adjacents << new_word
        end
      end
    end
    adjacents
  end
end



if __FILE__ == $PROGRAM_NAME
  chainer = WordChainer.new
  chainer.run('cat', 'dog')
end