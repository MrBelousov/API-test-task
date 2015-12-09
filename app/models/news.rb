class News < ActiveRecord::Base
  belongs_to :user

  enum status: {
           pending_approval: 0,
           published: 1
       }
end
