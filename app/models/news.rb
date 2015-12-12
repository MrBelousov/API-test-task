class News < ActiveRecord::Base
  # Associations
  belongs_to :user
  has_many :comments
  has_many :ratings

  # News state
  enum status: {
    pending_approval: 0,
    published: 1
  }

  # Validations
  validates :news_text, presence: true
end
