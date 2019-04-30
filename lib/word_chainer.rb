require 'set'
class WordChainer
  attr_reader :dictionary

  def initialize
    @dictionary = self.get_dictionary()
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
  p chainer.adjacent_words('cat')
end