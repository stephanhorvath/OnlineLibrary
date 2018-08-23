##
# This class stores information about superclass user.
#
# == Attributes
#
# * first_name: string
# * last_name: string
# * address_line_1: string
# * address_line_2: string (can be null)
# * town: string
# * post_code: string
# * tel_no: string
# * email: string
# * password_digest: string - generated after entering password
#   and password confirmation in sign up form.
# * type: string
# * remember_digest: string - token for remembering logged in user.
# * customer_id: string - null for all child classes except
#   'member' - generated by Stripe when subscribing
# * plan_id: integer - null for all child classes except
#   'member'
# * subscription_id: string - null for all child classes except
#   'member' - generated by Stripe when subscribing.
#
#
class User < ApplicationRecord
  # create get/set for remember_token attribute.
  attr_accessor :remember_token

  # sets email string to all lowercase before saving.
  before_save { self.email = email.downcase }

  # REGEX validation for tel_no
  VALID_PHONE_REGEX = /\A(?:0|\+?44)(?:\d\s?){9,10}\z/

  # REGEX validation for email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  # REGEX validation for post_code
  VALID_POST_CODE_REGEX = /\A([Gg][Ii][Rr] 0[Aa]{2})|((([A-Za-z][0-9]{1,2})|(([A-Za-z][A-Ha-hJ-Yj-y][0-9]{1,2})|(([A-Za-z][0-9][A-Za-z])|([A-Za-z][A-Ha-hJ-Yj-y][0-9]?[A-Za-z])))) [0-9][A-Za-z]{2})$\z/i

  validates :first_name,      presence: true, length: { maximum: 50 }
  validates :last_name,       presence: true, length: { maximum: 50 }
  validates :address_line_1,  presence: true, length: { maximum: 50 }
  validates :address_line_2,  length: { maximum: 50 }, allow_nil: true
  validates :town,            presence: true, length: { maximum: 50 }
  validates :post_code,       presence: true, length: { maximum: 10 }, format: { with: VALID_POST_CODE_REGEX }
  validates :tel_no,          presence: true, length: { minimum: 9, maximum: 12 }, format: { with: VALID_PHONE_REGEX }
  validates :email,           presence: true, length: { maximum: 100 }, uniqueness: { case_sensitive: false },
                              format: { with: VALID_EMAIL_REGEX }
  validates :type,            presence: true, length: { maximum: 15 }

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  # Associations
  # User has many loans.
  has_many :loans, dependent: :nullify

  # Methods

  # Returns hash of given string
  # using the BCrypt Engine.
  def User.digest(string)
    # Generates a hashing cost.
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost

    # Creates an encrypted password using the generated cost.
    BCrypt::Password.create(string, cost: cost)
  end

  # Return random 64bit token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remember user for persistent sessions.
  # Users User.new_token and assigns it to remember_digest.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if token matches digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    # Compares user's remember_token with the remember_digest
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user by making remember_digest nil.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Concatenates first_name and last_name
  def full_name
    self.first_name + ' ' + self.last_name
  end

end