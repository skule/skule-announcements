class CreateAnnouncementsTags < ActiveRecord::Migration
  def self.up
  	create_table :announcements_tags, :id => false do |t|
      t.integer :announcement_id
      t.integer :tag_id
    end
  end

  def self.down
	drop_table :announcements_tags
  end
end
