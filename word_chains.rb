require "set"

class WordChainer

  def initialize(dictionary_file_name)
    words = File.readlines(dictionary_file_name).map(&:chomp)
    @dictionary = Set.new(words)
    @temp = nil
  end

  def run(source,target)
    @current_words = [source]
    @all_seen_words = [source]

    until @current_words.empty? #outer loop
      new_current_words = []
      @current_words.each do |entry|  # second loop

        adjacent_words(entry).each do |term|  # third loop
          unless @all_seen_words.include?(term)
            new_current_words << term
            @all_seen_words << term
          end
        end

      end
      @current_words = new_current_words
      p @current_words
    end
  end
  
  def adjacent_words(word)
    alpha = ("a".."z").to_a
    a_words = []
    word.length.times do |i|
      #new_word = word
      alpha.each do |letter|
        word[i] = letter
        a_words << word.dup if @dictionary.include?(word)
        end
    end
    a_words
  end
  # def adjacent_words(word)
  #   same_lengthes = same_length_words(word)
  #   same_lengthes.select do |entry|
  #     counter = 0
  #     word.length.times do |i|
  #       counter += 1 unless word[i] == entry[i]
  #     end
  #     counter == 1
  #   end
  # end

  # def same_length_words(word)
  #   @dictionary.select do |entry|
  #     entry.length == word.length
  #   end
  # end
end
