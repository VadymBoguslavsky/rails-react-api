class User < ApplicationRecord
  before_create :confirmation_token
  has_many :tasks#, dependent: :destroy

  validates :last_name, presence: true
  validates :first_name, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  def email_activate
    self.email_confirmation = true
    self.email_token = nil
    save!(:validate => false)
  end

  private
    def confirmation_token
      if self.email_token.blank?
        self.email_token = SecureRandom.urlsafe_base64.to_s
      end
    end
end