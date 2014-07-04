require "layout_convert"

describe "A magic mixin module" do
  let(:latin_example) { 'hello world' }
  let(:cyrillic_example) { 'здравствуй, мир' }
  let(:mixed_example) { 'здравствуй, мир world' }

  let(:latin_example_in_cyrillic) { 'руддщ цщкдв' }
  let(:cyrillic_example_in_latin) { 'plhfdcndeq? vbh' }

  let(:mixed_example_puzzle) { "Z ckeif. njkmrj Кщслфишддн" }
  let(:mixed_example_puzzle_two) { "Вкштл мщвлф фтв здфн ,fkfkfqrf" }

  let(:mixed_example_puzzle_solution) { "Я слушаю только Rockabilly" }
  let(:mixed_example_puzzle_two_solution) { "Drink vodka and play балалайка" }

  describe "has the 'guess_layout'" do
    it "should guess the latin layout of the string with latin chars" do
      expect(latin_example.send('guess_layout')).to be_equal :lat
    end
    it "should guess the cyrillic layout of the string with cyrillic chars" do
      expect(cyrillic_example.send('guess_layout')).to be_equal :cyr
    end
    it "should guess the mixed layout of the string with cyrillic and latin chars" do
      expect(mixed_example.send('guess_layout')).to be_equal :mixed
    end
  end

  describe "has the 'cyrillic?' method" do
    it "should return true if the given string is cyrillic" do
      expect(cyrillic_example.cyrillic?).to be true
    end

    it "should return false if the given string is latin" do
      expect(latin_example.cyrillic?).to be false
    end

    it "should return false if the given string is both latin and cyrillic" do
      expect(mixed_example.cyrillic?).to be false
    end
  end

  describe "has the 'latin?' method" do
    it "should return false if the given string is cyrillic" do
      expect(cyrillic_example.latin?).to be false
    end

    it "should return true if the given string is latin" do
      expect(latin_example.latin?).to be true
    end

    it "should return false if the given string is both latin and cyrillic" do
      expect(mixed_example.latin?).to be false
    end
  end

  describe "has the 'mixed?' method" do
    it "should return true if the given string is cyrillic" do
      expect(cyrillic_example.mixed?).to be false
    end

    it "should return false if the given string is latin" do
      expect(latin_example.mixed?).to be false
    end

    it "should return false if the given string is both latin and mixed" do
      expect(mixed_example.mixed?).to be true
    end
  end

  describe "has the 'latinish?' method" do
    it "should return true if there are more latin letters than cyrillic" do
      expect(mixed_example_puzzle.latinish?).to be true
    end
    it "should return false if there are more cyrillic letters than latin" do
      expect(mixed_example_puzzle_two.latinish?).to be false
    end
  end

  describe "has the 'cyrillish?' method" do
    it "should return true if there are more cyrillic letters than latin?" do
      expect(mixed_example_puzzle_two.cyrillish?).to be true
    end
    it "should return false if there are more latin letters than cyrillic" do
      expect(mixed_example_puzzle.cyrillish?).to be false
    end
  end

  describe "has the 'swap_layout' method" do
    it "should convert cyrillic string in latin to cyrillic" do
      expect(cyrillic_example_in_latin.swap_layout).to be_eql cyrillic_example
    end
    it "should convert cyrillic latin in cyrillic to latin" do
      expect(latin_example_in_cyrillic.swap_layout).to be_eql latin_example
    end
    describe "with mixed puzzles" do
      it "should convert latinish puzzle correctly" do
        expect(mixed_example_puzzle.swap_layout).to be_eql mixed_example_puzzle_solution
      end
      it "should convert cyrillish puzzle correctly" do
        expect(mixed_example_puzzle_two.swap_layout).to be_eql mixed_example_puzzle_two_solution
      end
    end
  end
end
