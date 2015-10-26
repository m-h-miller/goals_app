class Goal < ActiveRecord::Base

  belongs_to :user

  has_many :comments,
    class_name: "GoalComment",
    foreign_key: :goal_id,
    primary_key: :id

end
