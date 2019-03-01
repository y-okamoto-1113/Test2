require 'rails_helper'
require 'pry'

describe "validation career" do
  let(:user) {User.new( name: "aaa",
                        tel: "09069654963",
                        mail: "info@datora.jp", 
                        type_sex: "男",
                        # type_career: "大卒",
                        school_name: "関西大学",
                        familyRelation: "father",
                        familyRelationName: "okamoto taro",
                        # created_at: "2019-02-25 19:41:03",
                        # updated_at: "2019-02-25 19:41:03"
                        )}
  
######################################################################### 結局これだけ保存しようとしてるからどの道、エラー
  describe "success" do
    example "uni" do
      user.type_career = '大卒'
      expect(user.save).to eq true
    end
    example "high" do
      user.type_career = '高卒'
      expect(user.save).to eq true
    end
    example "juni" do
      user.type_career = '中卒'
      expect(user.save).to eq true
    end
    example "no" do
      user.type_career = '学歴無し'
      expect(user.save).to eq true
    end

    example "fail1" do
      user.type_career = '大卒学歴無し'
      expect(user.save).to eq true
    end
    example "fail2" do
      user.type_career = 'あああ学歴無し'
      expect(user.save).to eq true
    end
  end
  

  describe "number only" do #long,short
    example "long" do
      user.type_career = '1234567890987654098765412345678'
      # binding.pry
      expect(user.save).to eq true
    end

    example "short" do
      user.type_career = '8'
      expect(user.save).to eq true
    end
  end
#########################################################################
  describe "Alphabet only" do #long,short,big,small
    example "BIG long" do
      user.type_career ='AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'
      expect(user.save).to eq true
    end

    example "BIG short" do
      user.type_career = 'A'
      expect(user.save).to eq true
    end

    example "small long" do
      user.type_career = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaa'
      expect(user.save).to eq true
    end

    example "small short" do
      user.type_career = 'a'
      expect(user.save).to eq true
    end
  end
############################################################################
  describe "multibyte-character only" do #漢字、ひらがな、カタカナ、long,short
    example "漢字only long" do
      user.type_career = '岡本太郎岡本太郎岡本太郎岡本太郎岡本太郎岡本太郎岡本太郎岡本太郎岡本太郎'
      expect(user.save).to eq true
    end

    example "漢字only short" do
      user.type_career = '岡'
      expect(user.save).to eq true
    end

    example "ひらがなonly long" do
      user.type_career = 'あああああああああああああああああああああああああああああああ'
      expect(user.save).to eq true
    end

    example "ひらがなonly short" do
      user.type_career = 'あ'
      expect(user.save).to eq true
    end

    example "カタカナonly long" do
      user.type_career = 'アアアアアアアアアアアアアアアアアアアアアアアアアアアアアアア'
      expect(user.save).to eq true
    end

    example "カタカナonly short" do
      user.type_career = 'ア'
      expect(user.save).to eq true
    end
  end
end







