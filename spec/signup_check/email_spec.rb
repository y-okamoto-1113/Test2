require 'rails_helper'
require 'pry'

describe "validation mail" do
  let(:user) {User.new( name:"aaa",
                        tel:"09069654963",
                        #mail:"info@datora.jp", 
                        type_sex: "男",
                        type_career: "大卒",
                        school_name: "関西大学",
                        familyRelation: "father",
                        familyRelationName: "okamoto taro",
                        # created_at: "2019-02-25 19:41:03",
                        # updated_at: "2019-02-25 19:41:03"
                        )}
  
#########################################################################  まだ途中
  describe "number only" do #long,short
    example "long" do
      user.mail = '1234567890987654098765412345678'
      # binding.pry
      expect(user.save).to eq true
    end

    example "short" do
      user.mail = '8'
      expect(user.save).to eq true
    end
  end
#########################################################################
  describe "Alphabet only" do #long,short,big,small
    example "BIG long" do
      user.mail ='AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'
      expect(user.save).to eq true
    end

    example "BIG short" do
      user.mail = 'A'
      expect(user.save).to eq true
    end

    example "small long" do
      user.mail = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaa'
      expect(user.save).to eq true
    end

    example "small short" do
      user.mail = 'a'
      expect(user.save).to eq true
    end
  end
############################################################################
  describe "multibyte-character only" do #漢字、ひらがな、カタカナ、long,short
    example "漢字only long" do
      user.mail = '岡本太郎岡本太郎岡本太郎岡本太郎岡本太郎岡本太郎岡本太郎岡本太郎岡本太郎'
      expect(user.save).to eq true
    end

    example "漢字only short" do
      user.mail = '岡'
      expect(user.save).to eq true
    end

    example "ひらがなonly long" do
      user.mail = 'あああああああああああああああああああああああああああああああ'
      expect(user.save).to eq true
    end

    example "ひらがなonly short" do
      user.mail = 'あ'
      expect(user.save).to eq true
    end

    example "カタカナonly long" do
      user.mail = 'アアアアアアアアアアアアアアアアアアアアアアアアアアアアアアア'
      expect(user.save).to eq true
    end

    example "カタカナonly short" do
      user.mail = 'ア'
      expect(user.save).to eq true
    end
  end
end







