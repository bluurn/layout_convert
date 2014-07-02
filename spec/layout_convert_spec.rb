require "layout_convert"

RSpec.describe "A magic layout convert class" do
  
  it "should guess the en layout" do
    lc_instance_en = LayoutConvert.new('Jackdaws love my big sphinx of quartz')
    expect(lc_instance_en.send('guess_layout')).to eq(:lat)
  end

  it "should guess the ru layout" do
    lc_instance_ru = LayoutConvert.new('Андрюх, у нас труп, возможно криминал, по коням!')
    expect(lc_instance_ru.send('guess_layout')).to eq(:cyr)
  end

  it "should convert lowercase string layout from En to Ru" do
    instance = LayoutConvert.new("ghbdtn!") 
    expect(instance.switch_layout).to eq("привет!")
  end

  it "should convert uppercase string layout from En to Ru" do
    instance = LayoutConvert.new("GHBDTN!") 
    expect(instance.switch_layout).to eq("ПРИВЕТ!")
  end

  it "should convert lowercase string layout from Ru to En" do
    instance = LayoutConvert.new("привет!") 
    expect(instance.switch_layout).to eq("ghbdtn!")
  end

  it "should convert uppercase string layout from Ru to En" do
    instance = LayoutConvert.new("ПРИВЕТ!") 
    expect(instance.switch_layout).to eq("GHBDTN!")
  end
  
  it "should convert mixed case string layout from Ru to En" do
    instance = LayoutConvert.new("GHBdTN!") 
    expect(instance.switch_layout).to eq("ПРИвЕТ!")
  end
  
  it "should convert mixed case string layout from En to Ru" do
    instance = LayoutConvert.new("ПРИвЕТ!") 
    expect(instance.switch_layout).to eq("GHBdTN!")
  end

  it "should not break initial layout on double conversion" do
    instance = LayoutConvert.new("ПРИвЕТ!") 
    instance.switch_layout
    expect(instance.switch_layout).to eq("ПРИвЕТ!")
  end
end
