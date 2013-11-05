class Diagram < String
  def is_valid?
    result = self.length > 0
    self.length.times do |n|
      result = (self.include?(n.to_s) and result)
    end
    result
  end
end

def mix(word, diagram)
  if word.length == diagram.length and diagram.is_valid?
    result = []
    diagram.split(//).each_with_index do |n, index|
      result[n.to_i] = word[index]
    end
    result.join
  else
    false
  end
end

def find_matches(words, diagram)
  if diagram.is_valid?
    matches = []
    words.keep_if {|word| word.length == diagram.length}
    words.each do |word|
      mixed = mix(word, diagram)
      if words.include?(mixed)
        puts "#{word} -> #{mixed}"
        matches.push [word, mixed]
      end
    end
    puts "none found" if matches == []
  else
    puts "diagram not valid"
  end
end

def find_matches_unique_letters(words, diagram)
  words.keep_if {|word| word.split(//).uniq.join == word}
  find_matches(words, diagram)
end

print "Type out the diagram: "
diagram = Diagram.new(str=gets.strip)
words = IO.readlines("words.txt").map {|word| word.strip}

print "Require letters to be unique? (Y/N) "
if gets.strip.upcase == "N"
  find_matches(words, diagram)
else
  find_matches_unique_letters(words, diagram)
end