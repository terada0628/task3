class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books,dependent: :destroy
  has_many :favorites,dependent: :destroy
  has_many :post_comments,dependent: :destroy

  attachment :profile_image

  validates :name, uniqueness: true
  validates :name, length: {in: 2..20}
  validates :introduction, length: {maximum: 50}



# ↓↓↓↓↓フォロー機能↓↓↓↓↓

  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 自分がフォローされている側の関係性
  has_many :followers, through: :reverse_of_relationships, source: :follower
  # 自分をフォローしているUser

  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
    # 自分がフォローする側の関係性
  has_many :followings, through: :relationships, source: :followed
    # 自分がフォローしているUser

  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  # createはnewとsaveを合わせた動きをする

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  # fint_byによって1レコードを見つけ、destroyメソッドで削除をする

  def following?(user)
    followings.include?(user)
  end
  # include?によってそのuserをフォローしているか判定している

end

