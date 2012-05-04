class CreateAnnouncements < ActiveRecord::Migration
  def self.up
    create_table :announcements do |t|

      t.string    :title
      t.text      :description
      t.datetime  :start_time
      t.datetime  :end_time
      t.string    :location
      
      t.string    :website
      t.string    :contact
      t.string    :email
      t.date      :announce_start_time
      t.date      :announce_end_time

      t.boolean   :is_approved, :default => false

      t.timestamps
      
    end
  end

  def self.down
    drop_table :announcements
  end
end
