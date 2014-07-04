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


  def cyrillic?
    guess_layout.equal?(:cyr)
  end

  def latin?
    guess_layout.equal?(:lat)
  end

  def mixed?
    guess_layout.equal?(:mixed)
  end

  def latinish?
    latin_count = cyrillic_count = 0
    words = self.scan(SPLIT_REGEX)
    words.each do |word|
      if word.latin?
        latin_count+=1
      else
        cyrillic_count+=1
      end
    end
    latin_count > cyrillic_count
  end

  def cyrillish?
    !self.latinish?
  end

  def change_layout
    layout_map = if self.latin? then
                   Hash[LAYOUTS[:lat].zip LAYOUTS[:cyr]]
                 elsif self.cyrillic?
                   Hash[LAYOUTS[:cyr].zip LAYOUTS[:lat]]
                 elsif self.latinish?
                   throw "Not implemented"
                 elsif self.cyrillish?
                   throw "Not implemented"
                 end

    self.scan(/./).map do |ch|
      layout_map[ch].nil? ? ch : layout_map[ch]
    end.join
  end

  private

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
end
