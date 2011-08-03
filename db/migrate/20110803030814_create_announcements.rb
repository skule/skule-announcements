class CreateAnnouncements < ActiveRecord::Migration
  def self.up
    create_table :announcements do |t|
      t.string :title
      t.text :description
      t.date :start_time
      t.date :end_time
      t.string :location
      t.string :contact
      t.string :email
      t.date :announce_start_time
      t.date :announce_end_time

      t.timestamps
    end
  end

  def self.down
    drop_table :announcements
  end
end
