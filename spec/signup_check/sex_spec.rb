require 'rails_helper'
require 'pry'

describe "validation sex" do
  let(:user) {User.new( name: "aaa",
                        tel: "09069654963",
                        mail: "info@datora.jp", 
                        # type_sex: "男",
                        type_career: "大卒",
                        school_name: "関西大学",
                        familyRelation: "father",
                        familyRelationName: "okamoto taro",
                        # created_at: "2019-02-25 19:41:03",
                        # updated_at: "2019-02-25 19:41:03"
                        )}
  
######################################################################### 結局これだけ保存しようとしてるからどの道、エラー
  describe "success" do # 男、女、男女
    example "man" do
      user.type_sex = '男'
      expect(user.save).to eq true
    end

    example "woman" do
      user.type_sex = '女'
      expect(user.save).to eq true
    end

    example "double" do
      user.type_sex = '男女'
      expect(user.save).to eq true
    end

    example "man man" do
      user.type_sex = '男男男男男男男男男男男男男男男男男男'
      expect(user.save).to eq true
    end

    example "wo wo" do
      user.type_sex = '女女女女女女女女女女女女女女女女女女女'
      expect(user.save).to eq true
    end

    example "wo wo" do
      user.type_sex = '女女aaaaa4btdf４５ウェrヴァsd女'
      expect(user.save).to eq true
    end
  end

  describe "number only" do #long,short
    example "long" do
      user.type_sex = '1234567890987654098765412345678'
      # binding.pry
      expect(user.save).to eq true
    end

    example "short" do
      user.type_sex = '8'
      expect(user.save).to eq true
    end
  end
#########################################################################
  describe "Alphabet only" do #long,short,big,small
    example "BIG long" do
      user.type_sex ='AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'
      expect(user.save).to eq true
    end

    example "BIG short" do
      user.type_sex = 'A'
      expect(user.save).to eq true
    end

    example "small long" do
      user.type_sex = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaa'
      expect(user.save).to eq true
    end

    example "small short" do
      user.type_sex = 'a'
      expect(user.save).to eq true
    end
  end
############################################################################
  describe "multibyte-character only" do #漢字、ひらがな、カタカナ、long,short
    example "漢字only long" do
      user.type_sex = '岡本太郎岡本太郎岡本太郎岡本太郎岡本太郎岡本太郎岡本太郎岡本太郎岡本太郎'
      expect(user.save).to eq true
    end

    example "漢字only short" do
      user.type_sex = '岡'
      expect(user.save).to eq true
    end

    example "ひらがなonly long" do
      user.type_sex = 'あああああああああああああああああああああああああああああああ'
      expect(user.save).to eq true
    end

    example "ひらがなonly short" do
      user.type_sex = 'あ'
      expect(user.save).to eq true
    end

    example "カタカナonly long" do
      user.type_sex = 'アアアアアアアアアアアアアアアアアアアアアアアアアアアアアアア'
      expect(user.save).to eq true
    end

    example "カタカナonly short" do
      user.type_sex = 'ア'
      expect(user.save).to eq true
    end
  end
end







