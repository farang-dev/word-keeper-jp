class User < ApplicationRecord
devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

validates :username, presence: true, uniqueness: true
has_many :words, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

end
