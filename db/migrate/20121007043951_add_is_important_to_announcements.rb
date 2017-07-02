class AddIsImportantToAnnouncements < ActiveRecord::Migration
  def self.up
	change_table :announcements do |t|
      t.boolean :is_important, :default => false
    end
  end

  def self.down
  	remove_column :announcements, :is_important
  end
end
