class SessionSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :status, :token

  def token
    object.token
  end
end
