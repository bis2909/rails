class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  validates :first_name, presence: true
  validates :last_name,  presence: true
  validate  :is_email

  private

  def is_email
    return if email.blank?
    errors.add(:email, 'is invalid') unless email =~ /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  end
end
