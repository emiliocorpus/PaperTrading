class Relationship < ActiveRecord::Base
  belongs_to :follower, class_name: "User"  # user who is following another user
  belongs_to :followed, class_name: "User"  # user who is being followed
  validates :follower_id, :followed_id, presence: true
end
