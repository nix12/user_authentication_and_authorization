class User < ApplicationRecord
  extend FriendlyId
  friendly_id :username, use: :slugged
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :registerable, :recoverable, :rememberable, :validatable
  devise :database_authenticatable, authentication_keys: [:username]

  has_and_belongs_to_many :roles

  VALID_USERNAME_REGEX = /[\w\s\|-]+/i

  validates :username, uniqueness: { case_sensitive: false }, 
                       presence: true, length: { minimum: 3, maximum: 10 },
                       format: { with: VALID_USERNAME_REGEX }

  def email_required?
    false
  end
  
  # use this instead of email_changed? for Rails = 5.1.x
  def will_save_change_to_email?
    false
  end

  # role methods are used with CanCanCan
  [:admin, :moderator, :member, :visitor].each do |role|
    define_method("#{role}?") { roles.exists?(name: role) }
  end

  def add_role(role)
    unless send("#{role}?")
      roles << Role.find_by(name: role)
    end
  end

  def remove_role(role)
    if send("#{role}?")
      roles.delete(Role.find_by(name: role))
    end
  end
end
