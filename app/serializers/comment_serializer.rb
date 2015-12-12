class CommentSerializer < ActiveModel::Serializer
  attributes :id, :owner_name, :comment_text

  # Associations
  has_many :ratings
end
