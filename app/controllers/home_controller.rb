class HomeController < ApplicationController
  def new
    @user = User.new
  end

  def index
    @users = User.all.order(created_at: :desc)
  end

  # ユーザー新規登録画面で入力したデータをデータベースに反映するため
  def create
    # binding.pry # createのメソッドに入ってるかをチェック　　paramsの中身確認
    @user = User.new(name: params[:name],
                     furigana: params[:furigana],
                     tel: params[:tel],
                     mail: params[:mail],
                     type_sex: params[:type_sex],    #下のところで「男」「女」以外を除去
                     type_career: params[:type_career],   #下のところで、「大卒」「高卒」「中卒」「学歴無し」以外はデータを取らんようにしてる。
                     school_name: params[:school_name],

                     familyRelation: params[:familyRelation],
                     familyRelationName: params[:familyRelationName]
                     
                     )                 
    # binding.pry # User.newでparamsが入ってるかチェック
    #生年月日は、全部記入した場合のみデータベース保存
    if !( params[:year]=="0" || params[:month]=="0" || params[:day]=="0" )
      @user.year = params[:year]
      @user.month = params[:month]
      @user.day = params[:day]
    end

    # 家族構成は「続柄」と「名前」両方が記入されていた場合のみデータベースに保存
    if !(params[:familyRelation2]=="" || params[:familyRelationName2]=="" )
      @user.familyRelation2 =  params[:familyRelation2]
      @user.familyRelationName2 = params[:familyRelationName2]
    end
    if !(params[:familyRelation3]=="" || params[:familyRelationName3]=="" )
      @user.familyRelation3 = params[:familyRelation3]
      @user.familyRelationName3 = params[:familyRelationName3]
    end
    # binding.pry
    
    @tel = @user.tel
    @tel.delete!('-')
    # binding.pry

    # リファクタリング。バリデーションで同じ確認してるからここで書く必要ない！！！！！！
    # 既に使用されている電話番号とメアドが入力されたら、エラーを返す！
    # @tel.delete!("-") # ハイフン削除させる。ハイフン有りと無しバージョンの同じ電話番号が存在してしまうから。
    # if ((User.find_by(tel: @tel) || (User.find_by(mail: @user.mail)) 
    #    flash.now[:alert] = "電話番号またはメールアドレスが既に使われています！" #flash[:notice]に格納されてるだけやから表示されへん。Viewの「application.html」に書く！！！
    #   #  return
    #    binding.pry
      
    # end
    
    # binding.pry
    if @user.save
      flash[:notice] = "ユーザー登録が完了しました"
      # binding.pry

      redirect_to("/")
      return
    else
      # binding.pry
      flash.now[:alert] = "電話番号またはメールアドレスが既に使われています！"
      
      @year = @user.year
      @month = @user.month
      @day = @user.day
      @type_career = @user.type_career
      @school_name = @user.school_name


      render action: :new
      
      # return# 1つのアクション（create）内で、renderとredirect_toを複数使うときは「(and) return」
      # @user = User.new()
      # render file: "/home/new"
    end
  end

end
