class List < ApplicationRecord
 has_one_attached :image
 belongs_to :user
 has_many :post_comments, dependent: :destroy
 has_many :favorites, dependent: :destroy
 has_many :tags, dependent: :destroy
 geocoded_by :habitat
 after_validation :geocode

 validates :name, presence: true
 validates :image, presence: true
 validates :introduction, presence: true
 validates :habitat, presence: true


 def get_image
   unless image.attached?
     file_path = Rails.root.join('app/assets/images/no_image.jpg')
     image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
   end
     image
 end

 def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
 end

 # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @list = List.left_joins(:tags).where("lists.name LIKE ? OR lists.habitat LIKE ? OR lists.introduction LIKE ? OR tags.name LIKE ?", "#{word}", "#{word}", "#{word}", "#{word}").distinct
    elsif search == "forward_match"
      @list = List.left_joins(:tags).where("lists.name LIKE ? OR lists.habitat LIKE ? OR lists.introduction LIKE ? OR tags.name LIKE ?", "#{word}%", "#{word}%", "#{word}%", "#{word}%").distinct
    elsif search == "backward_match"
      @list = List.left_joins(:tags).where("lists.name LIKE ? OR lists.habitat LIKE ? OR lists.introduction LIKE ? OR tags.name LIKE ?", "%#{word}", "%#{word}", "%#{word}", "%#{word}").distinct
    elsif search == "partial_match"
      @list = List.left_joins(:tags).where("lists.name LIKE ? OR lists.habitat LIKE ? OR lists.introduction LIKE ? OR tags.name LIKE ?", "%#{word}%", "%#{word}%", "%#{word}%", "%#{word}%").distinct 
    else
      @list = List.all
    end
  end

end
