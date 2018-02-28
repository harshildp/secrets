class Like < ActiveRecord::Base
  belongs_to :secret
  belongs_to :user
end
