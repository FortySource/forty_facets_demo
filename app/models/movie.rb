class Movie < ActiveRecord::Base
  belongs_to :genre
  belongs_to :studio
  has_and_belongs_to_many :actors
  has_and_belongs_to_many :writers

  scope :classics, -> { where(is_classic: true) }
end
