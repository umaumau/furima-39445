class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :password, format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/, message: "は半角英数字を含めてください" }
  validates :nickname, presence: true
  validates :last_name, presence: true, format: { with: /[一-龠々]|[ぁ-ん]|[ァ-ヴ]/, message: "は全角で入力してください"}
  validates :first_name, presence: true, format: { with: /[一-龠々]|[ぁ-ん]|[ァ-ヴ]/, message: "は全角で入力してください"}
  validates :last_name_kana, presence: true, format: { with: /[ァ-ヴ]/, message: "は全角カナで入力してください"}
  validates :first_name_kana, presence: true, format: { with: /[ァ-ヴ]/, message: "は全角カナで入力してください"}
  validates :birth, presence: true

  # has_many :items
  # has_many :orders

end
