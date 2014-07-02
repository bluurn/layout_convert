
class ::String
  
  LAYOUTS = {
    lat: %q!qwertyuiop[]asdfghjkl;'zxcvbnm,./QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>?!.scan(/./),
    cyr:  %q!йцукенгшщзхъфывапролджэячсмитьбю.ЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ,!.scan(/./)
  }

  LANG = {
    lat: ('a'..'z').to_a + ('A'..'Z').to_a,
    cyr: ('а'..'я').to_a + ('А'..'Я').to_a
  }

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
end
