module ApplicationHelper

  def title_string(second_part)
    'Skule Announcements' + (second_part != nil ? ' | ' + second_part.to_s : '')
  end

end
