class Group < ActiveRecord::Base
  belongs_to :user
  belongs_to :admin

  has_many :group_users
  has_many :members, through: :group_users, source: :user

end
