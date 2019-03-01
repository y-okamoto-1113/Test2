require 'rails_helper'
require 'pry'

describe "validation tel" do
  let(:user) {User.new( name: "aaa",
                        # tel:"09069654963",
                        mail: "info@datora.jp", 
                        type_sex: "男",
                        type_career: "大卒",
                        school_name: "関西大学",
                        familyRelation: "father",
                        familyRelationName: "okamoto taro",
                        # created_at: "2019-02-25 19:41:03",
                        # updated_at: "2019-02-25 19:41:03"
                        )}
  
######################################################################### 結局これだけ保存しようとしてるからどの道、エラー
  describe "success" do
    example "fail" do
      user.tel = '09012345678'
      expect(user.save).to eq true
    end
    example "fail" do
      user.tel = '090-6965-4963'
      expect(user.save).to eq true
    end
    example "hyphen fail" do
      user.tel = '090-1111-1111'
      expect(user.save).to eq true
    end
    example " /0[56789]0/ " do
      user.tel = '12345678900'
      expect(user.save).to eq true
    end
    example "/0[56789]0/ hyphen" do
      user.tel = '123-4567-8900'
      expect(user.save).to eq true
    end
    example "success" do
      user.tel = '08043216578' # rails c でも、ハイフン無し１１桁に限定できた
      expect(user.save).to eq true
    end


  end

  describe "number only" do #long,short
    example "long" do
      user.tel = '1234567890987654098765412345678'
      # binding.pry
      expect(user.save).to eq true
    end

    example "short" do
      user.tel = '8'
      expect(user.save).to eq true
    end
  end
#########################################################################
  describe "Alphabet only" do #long,short,big,small
    example "BIG long" do
      user.tel ='AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'
      expect(user.save).to eq true
    end

    example "BIG short" do
      user.tel = 'A'
      expect(user.save).to eq true
    end

    example "small long" do
      user.tel = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaa'
      expect(user.save).to eq true
    end

    example "small short" do
      user.tel = 'a'
      expect(user.save).to eq true
    end
  end
############################################################################
  describe "multibyte-character only" do #漢字、ひらがな、カタカナ、long,short
    example "漢字only long" do
      user.tel = '岡本太郎岡本太郎岡本太郎岡本太郎岡本太郎岡本太郎岡本太郎岡本太郎岡本太郎'
      expect(user.save).to eq true
    end

    example "漢字only short" do
      user.tel = '岡'
      expect(user.save).to eq true
    end

    example "ひらがなonly long" do
      user.tel = 'あああああああああああああああああああああああああああああああ'
      expect(user.save).to eq true
    end

    example "ひらがなonly short" do
      user.tel = 'あ'
      expect(user.save).to eq true
    end

    example "カタカナonly long" do
      user.tel = 'アアアアアアアアアアアアアアアアアアアアアアアアアアアアアアア'
      expect(user.save).to eq true
    end

    example "カタカナonly short" do
      user.tel = 'ア'
      expect(user.save).to eq true
    end
  end
end







