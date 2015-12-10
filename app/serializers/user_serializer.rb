class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :email, :status

  has_many :news
end
