class SessionSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :admin, :token

  def token
    object.token
  end
end
