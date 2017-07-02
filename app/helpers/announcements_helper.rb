module AnnouncementsHelper

	def is_owner(announcement_id, user_id)
		announcement = Announcement.find(announcement_id)
		return announcement.user_id == user_id
	end

end
