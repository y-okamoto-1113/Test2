class UsersController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :authenticate_admin!
  before_action :find_user, only:[:show, :edit, :update, :destroy]
  # before_action :validate_user, only:[:show, :edit, :update, :destroy]  今回は使わん
  PER=30

  def index
    # binding.pry
    if params[:search]
      # @users = User.where(name: params[:search] )  こっちは全文字一致しか出力せーへんからアカン。
      # 「will_paginate」で@usersの値を取ってるが、@users自体のデータがwill_paginateに対応してないから、「.paginate」で読めるように整形する
      @users = User.where(['name LIKE ?', "%#{params[:search]}%"]).paginate(page: params[:page], per_page: 10)
    else
      # @users = User.page(params[:page]).per(PER)
      # @users = User.all.order(created_at: :desc)
      @users = User.paginate(page: params[:page], per_page: 10) #1ページ30個表示。30個行かんかったら、ページネーションが表示されへん！！！！
    end
  end

  def show

  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    # binding.pry
    @user = User.new(name: params[:name],
                     furigana: params[:furigana],
                     tel: params[:tel],
                     mail: params[:mail],
                     type_sex: params[:type_sex],    #下のところで「男」「女」以外を除去
                     type_career: params[:type_career],   #下のところで、「大卒」「高卒」「中卒」「学歴無し」以外はデータを取らんようにしてる。
                     school_name: params[:school_name],

                     familyRelation: params[:familyRelation],
                     familyRelationName: params[:familyRelationName],
                     position: params[:position],
                     remarks: params[:remarks],
                     joined_year: params[:joined_year],
                     joined_month: params[:joined_month],
                     joined_day: params[:joined_day],
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
    # binding.pry
    if @user.save
      redirect_to root_path, notice:'ユーザーを作成できました'
    else

      @year = @user.year
      @month = @user.month
      @day = @user.day
      @type_career = @user.type_career
      @school_name = @user.school_name
      @joined_year = @user.joined_year
      @joined_month = @user.joined_month
      @joined_day = @user.joined_day
      # binding.pry
      render :new, alert: 'ユーザーを作成できませんでした'
      # binding.pry
    end
  end



  def update
    @tel = @user.tel
    @tel.delete!('-')
    if @user.update(name: params[:name],
                  furigana: params[:furigana],
                  tel: params[:tel],
                  mail: params[:mail],
                  year: params[:year],
                  month: params[:month],
                  day: params[:day],
                  type_sex: params[:type_sex],
                  type_career: params[:type_career],
                  school_name: params[:school_name],
                  familyRelation: params[:familyRelation],
                  familyRelationName: params[:familyRelationName],
                  familyRelation2: params[:familyRelation2],
                  familyRelationName2: params[:familyRelationName2],
                  familyRelation3: params[:familyRelation3],
                  familyRelationName3: params[:familyRelationName3],
                  position: params[:position],
                  remarks: params[:remarks], 
                  joined_year: params[:joined_year],
                  joined_month: params[:joined_month],
                  joined_day: params[:joined_day]
      )
      redirect_to root_path, notice:'更新しました'
    else
      @year = @user.year
      @month = @user.month
      @day = @user.day
      @type_career = @user.type_career
      @school_name = @user.school_name
      @joined_year = @user.joined_year
      @joined_month = @user.joined_month
      @joined_day = @user.joined_day
      render :edit, alert:'更新できませんでした'
    end
  end



  def destroy
    # binding.pry
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

  # 並べ替え順（asc、desc）と並べ替え元となるカラム名のデフォルト値を返し、また値が正常であるかを確認するためのメソッドを定義
  def sort_direction
    # binding.pry
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end

  def sort_column
      User.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  # Strong Parameters
  # def user_params
  #   params.require(:user).permit(:name, :furigana, :tel, :mail, :type_sex, :birthday, :type_career, :school_name,
  #                                :familyRelation, :familyRelationName, :familyRelation2, , :familyRelationName2, :familyRelation3, :familyRelationName3)
  # end


end
