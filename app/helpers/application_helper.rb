module ApplicationHelper
  def full_title(title)
    title.blank? ? 'TweetHeart' : "TweetHeart | #{title}"
  end
end
