atom_feed do |feed|
  feed.title("Skule Announcements")
  feed.updated(@current_approved_announcements[0].created_at) if @current_approved_announcements.length > 0

  @current_approved_announcements.each do |announcement|
    feed.entry(announcement) do |entry|
      entry.title(announcement.title)
      entry.content(announcement.html_description, :type => 'html')

      entry.author do |author|
        if announcement.user != nil
          author.name(announcement.user.full_name)
        end
      end
    end
  end
end