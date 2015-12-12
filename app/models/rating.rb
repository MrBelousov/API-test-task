class Rating < ActiveRecord::Base
  # Associations
  belongs_to :user
  belongs_to :news
  belongs_to :comment
end
