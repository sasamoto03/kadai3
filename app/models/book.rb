class Book < ApplicationRecord

  has_one_attached :image
  belongs_to :user

  has_one_attached :profile_images

  validates :title, presence: true
  validates :body, length: {minimum:1, maximum:200}, presence: true

  def get_profile_image(width, height)
  unless profile_image.attached?
    file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
    profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end
  profile_image.variant(resize_to_limit: [width, height]).processed
  end
end
