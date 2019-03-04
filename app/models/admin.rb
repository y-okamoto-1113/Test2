class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # https://qiita.com/cigalecigales/items/f4274088f20832252374
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :trackable, :timeoutable,
         :omniauthable 
         #, :omniauth_providers[:twitter, :facebook]
end
