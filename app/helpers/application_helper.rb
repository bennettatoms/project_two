module ApplicationHelper
  def full_title(title)
    title.blank? ? 'ProjectTwo' : "ProjectTwo | #{title}"
  end
end
