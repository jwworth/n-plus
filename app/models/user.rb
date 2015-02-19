class User < ActiveRecord::Base
  has_many :comments
  has_many :reviews

  # Custom select
  #scope :with_comments_count, -> { joins(:comments).select("users.*, COUNT(comments.id) AS comments_count").group("users.id") }
end
