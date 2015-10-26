class GoalComment < ActiveRecord::Base
  belongs_to :goal
  
  belongs_to :commenter,
    class_name: "User",
    foreign_key: :commenter_id,
    primary_key: :id
end
