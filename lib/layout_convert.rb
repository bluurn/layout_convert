##
# Mix-in necessary methods to make layout swap available

class ::String

  LAYOUTS = {
    lat: %q!qwertyuiop[]asdfghjkl;'zxcvbnm,./QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>?!.scan(/./),
    cyr:  %q!йцукенгшщзхъфывапролджэячсмитьбю.ЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ,!.scan(/./)
  }

  LANG = {
    lat: ('a'..'z').to_a + ('A'..'Z').to_a,
    cyr: ('а'..'я').to_a + ('А'..'Я').to_a
  }

  SPLIT_REGEX =/[a-zA-Zа-яА-Я\[\];',\.\/{}:"<>?]+/

  ##
  # Detect whether the given string is cyrillic

  def cyrillic?
    guess_layout.equal?(:cyr)
  end

  ##
  # Detect whether the given string is latin
  def latin?
    guess_layout.equal?(:lat)
  end

  ##
  # Detect whether the given string has both latin and cyrillic letters

  def mixed?
    guess_layout.equal?(:mixed)
  end

  ##
  # Detect whether the given string has more latin letters
  def latinish?
    latin_count = cyrillic_count = 0
    split_words.each do |word|
      if word.latin?
        latin_count+=1
      else
        cyrillic_count+=1
      end
    end
    latin_count > cyrillic_count
  end

  ##
  # Detect whether the given string has more cyrillic letters
  def cyrillish?
    !self.latinish?
  end

  ##
  # Swap the layout
  def swap_layout
    if self.latinish? || self.cyrillish?
      split_words.map do |word|
        layout_map = set_layout word
        word.scan(/./).map do |ch|
          layout_map[ch].nil? ? ch : layout_map[ch]
        end.join
      end.join ' '
    end
  end

  private

  ##
  # Guess the layout

  def guess_layout
    letters = self.scan(/[[:alpha:]]/).uniq
    if (letters - LANG[:lat]).empty?
      :lat
    elsif (letters - LANG[:cyr]).empty?
      :cyr
    else
      :mixed
    end
  end

  ##
  # Split words using tricky regex

  def split_words
    self.scan SPLIT_REGEX
  end

  ##
  # Set the layout hash

  def set_layout(word = self)
    if word.latin?
      Hash[LAYOUTS[:lat].zip LAYOUTS[:cyr]]
    elsif word.cyrillic?
      Hash[LAYOUTS[:cyr].zip LAYOUTS[:lat]]
    else
      throw "Cannot detect layout"
    end
  end
end
