class User < ApplicationRecord
  has_many :favorite, dependent: :destroy
  has_many :review
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
<<<<<<< HEAD
<<<<<<< HEAD
         :recoverable, :rememberable, :validatable

  enum gender: { "male": 0, "female": 1, "other": 2 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true, length: { in: 1..30 }       
  validates :email, presence: true, length: { maximum: 100 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  validates :password, presence: true, length: { minimum: 6 } ,allow_nil: true
  validates :address, presence: true, length: { in: 5..60 }
  validates :gender, presence: true
  validates :nickname, length: { in: 1..30 }, allow_blank: true
=======
=======
>>>>>>> b5bc804... googleログイン機能実装
         :recoverable, :rememberable, :validatable, :trackable, :omniauthable, omniauth_providers: %i(google)
  protected
  def self.find_for_google(auth)
    user = User.find_by(email: auth.info.email)

    unless user
      user = User.create(name:     auth.info.name,
                         email: auth.info.email,
                         provider: auth.provider,
                         uid:      auth.uid,
                         token:    auth.credentials.token,
                         password: Devise.friendly_token[0, 20],
                         meta:     auth.to_yaml)
    end
    user
  end
<<<<<<< HEAD
>>>>>>> b5bc804... googleログイン機能実装
=======
>>>>>>> b5bc804... googleログイン機能実装
end
