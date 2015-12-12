class NewsSerializer < ActiveModel::Serializer
  attributes :id, :news_text, :status, :created_at

  # Associations
  has_many :comments
  has_one :user
  has_many :ratings
end
