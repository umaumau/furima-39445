class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :password, format: { with: /\A(?=.*?[a-zA-Z])(?=.*?[\d])[a-zA-Z\d]+\z/, message: "は半角英数字を含めてください" }
  validates :nickname, presence: true
  validates :last_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: '全角文字を使用してください' }
  validates :first_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: '全角文字を使用してください' }
  validates :last_name_kana, presence: true, format: { with: /\A[ァ-ヶー]+\z/, message: 'は全角カナを使用してください' }
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー]+\z/, message: 'は全角カナを使用してください' }
  validates :birth, presence: true

  # has_many :items
  # has_many :orders

end
