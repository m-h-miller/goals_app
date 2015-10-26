class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true
  validates :password_digest, :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  after_initialize :ensure_session_token

  attr_reader :password

  has_many :goals
  
  has_many :goal_comments,
    class_name: "GoalComment",
    foreign_key: :commenter_id,
    primary_key: :id

  has_many :user_comments,
    class_name: "UserComment",
    foreign_key: :commenter_id,
    primary_key: :id

  has_many :comments,
    class_name: "UserComment",
    foreign_key: :user_id,
    primary_key: :id

  def self.find_by_credentials(username, password)
    @user = User.find_by_username(username)

    if @user.nil?
      nil
    elsif @user.is_password?(password)
      @user
    end
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(@password)
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64(16)
    self.save
    self.session_token
  end

  private

    def ensure_session_token
      self.session_token ||= SecureRandom.urlsafe_base64(16)
    end

end
