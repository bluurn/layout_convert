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

  def cyrillic?
    self.guess_layout.equal?(:cyr)
  end

  def latin?
    self.guess_layout.equal?(:lat)
  end

  def mixed?
    self.guess_layout.equal?(:mixed)
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

  def change_layout
    layout_map = if self.latin? then
                   Hash[LAYOUTS[:lat].zip LAYOUTS[:cyr]]
                 elsif self.cyrillic?
                   Hash[LAYOUTS[:cyr].zip LAYOUTS[:lat]]
                 end

    self.scan(/./).map do |ch|
      layout_map[ch].nil? ? ch : layout_map[ch]
    end.join
  end
end
