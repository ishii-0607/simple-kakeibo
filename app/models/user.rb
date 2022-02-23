class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :incomes, dependent: :destroy
  has_many :fixedcosts, dependent: :destroy
  has_many :variablecosts, dependent: :destroy
  has_many :costs, dependent: :destroy

end
