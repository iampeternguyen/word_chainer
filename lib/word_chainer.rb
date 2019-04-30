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
end

if __FILE__ == $PROGRAM_NAME
  chainer = WordChainer.new
  p chainer.dictionary
end