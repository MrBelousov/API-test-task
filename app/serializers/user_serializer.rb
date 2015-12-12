class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :email, :status

  # Associations
  has_many :news
end
