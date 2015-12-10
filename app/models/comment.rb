class Comment < ActiveRecord::Base
# Associations
  belongs_to :news

# Validations
  validates :owner_name, presence: true, length: { maximum: 20 }
  validates :comment_text, presence: true, length: { maximum: 140 }
end
