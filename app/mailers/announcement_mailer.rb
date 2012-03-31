class AnnouncementMailer < ActionMailer::Base
  default :from => "ben.mccanny@gmail.com"

  def digest

  	@announcements = Announcement.all_current_approved

  	mail(:to => "ben.mccanny@gmail.com", :subject => "Skule Announcements")

  end

end
