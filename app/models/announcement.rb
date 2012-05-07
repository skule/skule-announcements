class Announcement < ActiveRecord::Base

  belongs_to :user
  has_and_belongs_to_many :tags

  def self.all_current_approved
    self.where("announce_start_time <= ? AND announce_end_time >= ? AND is_approved = ?", Time.now, Time.now, true).order("start_time asc") 
  end

  def self.all_pending
    self.where("is_approved = ? OR is_approved = ?", false, nil).order("start_time asc")
  end

  def self.all_current_user(user_id)
    self.where("(is_approved = ? OR is_approved = ?) AND user_id = ?", false, nil, user_id).order("start_time asc")
  end

  def happening_on
    
  	is_multi_day = (end_time.month == start_time.month && end_time.day - start_time.day > 0) || (end_time.month - start_time.month > 0)

    if is_multi_day
    	if end_time.class == Date && start_time.class == Date
    		start_time.strftime("%B #{start_time.day.ordinalize}, %Y") + " - " + end_time.strftime("%B #{start_time.day.ordinalize}, %Y")
    	elsif end_time.hour == 0 && start_time.hour == 0
        start_time.strftime("%B #{start_time.day.ordinalize}, %Y") + " - " + end_time.strftime("%B #{start_time.day.ordinalize}, %Y")
      else
    		start_time.strftime("%l:%M %p, %B #{start_time.day.ordinalize}, %Y") + " - " + end_time.strftime("%l:%M %p, %B #{start_time.day.ordinalize}, %Y")
    	end
    else
      if end_time - start_time > 0
    	  start_time.strftime("%l:%M %p") + " - " + end_time.strftime("%l:%M %p, %B #{start_time.day.ordinalize}, %Y")
      else
        if end_time.hour == 0
          start_time.strftime("%B #{start_time.day.ordinalize}, %Y")
        else
          start_time.strftime("%l:%M %p, %B #{start_time.day.ordinalize}, %Y")
        end
      end
    end
    
  end
  
  def summary
    
    # Take the first two sentences of the announcement description
    description[/.+\. .+\./]
      
  end

end
