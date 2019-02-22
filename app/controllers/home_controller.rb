class HomeController < ApplicationController
  def new
  end

  def index
    @users = User.all.order(created_at: :desc)
  end

  # ユーザー新規登録画面で入力したデータをデータベースに反映するため
  def create
    @name = User.new(name: params[:name])
    @name.save
    @furingana =User.new(furigana: params[:furingana])
    @furigana.save
    @tel = User.new(tel: params[:tel])
    @tel.save
    @mail = User.new(mail: params[:mail])
    @mail.save
    @type_sex = User.new(type_sex: params[:type_sex])
    @type_sex.save
    @year = User.new(year: params[:year])
    @year.save
    @month = User.new(month: params[:month])
    @month.save
    @day = User.new(day: params[:day])
    @day.save
    @type_career = User.new(type_career: params[:type_career])
    @type_career.save

    redirect_to("/new")
  end



end
