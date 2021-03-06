class UserComment < ActiveRecord::Base
  belongs_to :user

  belongs_to :commenter,
    class_name: "User",
    foreign_key: :commenter_id,
    primary_key: :id

end
