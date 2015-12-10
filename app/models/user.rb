class User < ActiveRecord::Base
# Associations
  has_many :news
  has_one :api_key, dependent: :destroy

# Creating an api key for user
  after_create :create_api_key

# User state
  enum status: {
           common: 0,
           manager: 1,
           admin: 2
       }

# Validation
  validates :first_name, length: { maximum: 20 }

  private

  def create_api_key
    ApiKey.create :user => self
  end
end
