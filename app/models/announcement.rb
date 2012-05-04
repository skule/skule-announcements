class Announcement < ActiveRecord::Base

  def self.all_current_approved
    self.where("announce_start_time <= ? AND announce_end_time >= ? AND is_approved = ?", Time.now, Time.now, true).order("start_time asc") 
  end

  def self.all_pending
    self.where("is_approved = ? OR is_approved = ?", false, nil).order("start_time asc")
  end

  def happening_on
    
  	is_multi_day = (end_time.month == start_time.month && end_time.day - start_time.day > 0) || (end_time.month - start_time.month > 0)

    if is_multi_day
    	if(end_time.class == Date && start_time.class == Date)
    		start_time.strftime("%m/%d/%Y") + " - " + end_time.strftime("%m/%d/%Y")
    	else
    		start_time.strftime("%I:%M %p %m/%d/%Y") + " - " + end_time.strftime("%I:%M %p %m/%d/%Y")
    	end
    else
    	start_time.strftime("%I:%M %p") + " - " + end_time.strftime("%I:%M %p, %m/%d/%Y")
    end
    
  end
  
  def summary
    
    # Take the first two sentences of the announcement description
    description[/.+\. .+\./]
      
  end

end
