class Word < ApplicationRecord
  belongs_to :user
  validates :jptitle, presence: true
  validates :jpdescription, presence: true
  attr_accessor :reading

end
