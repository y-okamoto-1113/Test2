class UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :find_user, only:[:show, :edit, :update, :destroy]
  # before_action :validate_user, only:[:show, :edit, :update, :destroy]  今回は使わん

  def index
    @users = User.order(created_at: :desc)
  end

  def show

  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
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

    if !( params[:year]=="0" || params[:month]=="0" || params[:day]=="0" )
     @user.year = params[:year]
     @user.month = params[:month]
     @user.day = params[:day]
    end

    if !(params[:familyRelation2]=="" || params[:familyRelationName2]=="" )
     @user.familyRelation2 =  params[:familyRelation2]
     @user.familyRelationName2 = params[:familyRelationName2]
    end

    if !(params[:familyRelation3]=="" || params[:familyRelationName3]=="" )
     @user.familyRelation3 = params[:familyRelation3]
     @user.familyRelationName3 = params[:familyRelationName3]
    end

    @tel = @user.tel
    @tel.delete!('-')

    if @user.save
      redirect_to @user, notice:'ユーザーを作成できました'
    else

      @year = @user.year
      @month = @user.month
      @day = @user.day
      @type_career = @user.type_career
      @school_name = @user.school_name
      render :new, alert: 'ユーザーを作成できませんでした'
    end
  end



  def update
    if @user.update(user_params)
      redirect_to @user, notice:'更新しました'
    else
      render :edit, alert:'更新できませんでした'
    end
  end

  def destroy
    if @user.destroy
      redirect_to root_path, notice:'削除に成功しました'
    else
      redirect_to root_path,  alert:'削除できませんでした'
    end
  end

  private
  def find_user
    @user = User.find(params[:id])
  end


end
