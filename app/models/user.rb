class User < ApplicationRecord
  has_one_attached :profile_image
  
  has_many :lists, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  # フォローをした、されたの関係
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  
  # 一覧画面で使う
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower
  
  # DM画面で使う
  has_many :user_rooms
  has_many :chats
  has_many :rooms, through: :user_rooms
  
  def get_profile_image
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      profile_image
  end
  
   # フォローしたときの処理
  def follow(user_id)
  relationships.create(followed_id: user_id)
  end
  # フォローを外すときの処理
  def unfollow(user_id)
  relationships.find_by(followed_id: user_id).destroy
  end
  # フォローしているか判定
  def following?(user)
  followings.include?(user)
  end
  #検索機能
  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @user = User.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end
  #ゲストログイン
  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name ,presence: true, length: { minimum: 1, maximum: 20 }
  validates :email ,presence: true, uniqueness: true
end
