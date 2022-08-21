# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string           not null
#  is_public              :boolean          default(TRUE), not null
#  last_name              :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  username               :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         authentication_keys: [:login_identify],
         reset_password_keys: [:login_identify]

  attr_writer :login_identify

  validates :email, format: {
    with: URI::MailTo::EMAIL_REGEXP,
    message: 'must be a valid email address'
  }
  validates :username, uniqueness: true
  validates :first_name, presence: true

  has_many :posts

  has_many :bonds

  has_many :followings,
           -> { where(bonds: { state: Bond::FOLLOWING }) },
           through: :bonds,
           source: :friend

  has_many :follow_requests,
           -> { where(bonds: { state: Bond::REQUESTING }) },
           through: :bonds,
           source: :friend

  has_many :inward_bonds,
           class_name: 'Bond',
           foreign_key: :friend_id

  has_many :followers,
           -> { where(bonds: { state: Bond::FOLLOWING }) },
           through: :inward_bonds,
           source: :user

  before_save :ensure_proper_name_case

  def login_identify
    @login_identify || username || email
  end

  def gravatar_url
    hash = Digest::MD5.hexdigest(email)
    "https://www.gravatar.com/avatar/#{hash}?d=wavatar"
  end

  def self.find_authenticatable(login_identify)
    where('username = :value OR email = :value', value: login_identify).first
  end

  def self.find_for_database_authentication(conditions)
    conditions = conditions.dup
    login_identify = conditions.delete(:login_identify).downcase
    find_authenticatable(login_identify)
  end

  private

  def ensure_proper_name_case
    self.first_name = first_name.capitalize
  end
end
