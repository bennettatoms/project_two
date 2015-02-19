class Search < ActiveRecord::Base
  belongs_to :user

  validates :search_term, presence: true
end