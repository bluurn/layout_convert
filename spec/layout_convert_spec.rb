require "layout_convert"

describe "A magic mixin module" do

  describe "has the 'guess_layout'" do
    it "should guess the latin layout of the string with latin chars" do
      expect('hello world'.guess_layout).to be_equal :lat
    end
    it "should guess the cyrillic layout of the string with cyrillic chars" do
      expect('здравствуй, мир'.guess_layout).to be_equal :cyr
    end
    it "should guess the mixed layout of the string with cyrillic and latin chars" do
      expect('здравствуй, мир world'.guess_layout).to be_equal :mixed
    end
  end

  describe "has the 'cyrillic?' method" do
    it "should return true if the given string is cyrillic" do
      expect('здравствуй, мир'.cyrillic?).to be true
    end

    it "should return false if the given string is latin" do
      expect('hello world'.cyrillic?).to be false
    end

    it "should return false if the given string is both latin and cyrillic" do
      expect('здравствуй, мир world'.cyrillic?).to be false
    end
  end

end 
