class LayoutConvert 

  @@LAYOUTS = {
    lat: %q!qwertyuiop[]asdfghjkl;'zxcvbnm,./QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>?!.scan(/./),
    cyr:  %q!йцукенгшщзхъфывапролджэячсмитьбю.ЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ,!.scan(/./)
  }

  @@LANG = {
    lat: ('a'..'z').to_a + ('A'..'Z').to_a,
    cyr: ('а'..'я').to_a + ('А'..'Я').to_a
  }

  def initialize(string)
    @string = string
    @current_layout = guess_layout
  end

  def switch_layout
    layout_map = if @current_layout == :lat then
                   Hash[@@LAYOUTS[:lat].zip @@LAYOUTS[:cyr]]
                 else
                   Hash[@@LAYOUTS[:cyr].zip @@LAYOUTS[:lat]] 
                 end
    @current_layout = if @current_layout == :lat then :cyr else :lat end

    @string = @string.scan(/./).map do |ch| 
      layout_map[ch].nil? ? ch : layout_map[ch] 
    end.join
  end

  private
    
    def guess_layout 
      if (@string.scan(/[[:alpha:]]/).uniq - @@LANG[:lat]).empty? 
        :lat 
      else 
        :cyr 
      end
    end
end
