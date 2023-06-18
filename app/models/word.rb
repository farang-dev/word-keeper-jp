class Word < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :description, presence: true
  attr_accessor :reading

end
