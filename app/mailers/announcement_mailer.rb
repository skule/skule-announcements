class AnnouncementMailer < ActionMailer::Base
  default :from => "ben.mccanny@gmail.com"

  def digest

  	@announcements = Announcement.all_current

  	mail(:to => "ben.mccanny@gmail.com", :subject => "Skule Announcements")

  end

end
