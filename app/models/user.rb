class User < ActiveRecord::Base
  has_many :news
  has_one :api_key, dependent: :destroy
  after_create :create_api_key

  enum status: {
           common: 0,
           manager: 1,
           admin: 2
       }

  private

  def create_api_key
    ApiKey.create :user => self
  end
end
