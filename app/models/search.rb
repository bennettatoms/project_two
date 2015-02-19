class Search < ActiveRecord::Base
  belongs_to :user
  has_many :tweets

  validates :search_term, presence: true
end