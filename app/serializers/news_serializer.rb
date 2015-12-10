class NewsSerializer < ActiveModel::Serializer
  attributes :id, :news_text, :status, :created_at

  has_many :comments
  has_one :user
end
