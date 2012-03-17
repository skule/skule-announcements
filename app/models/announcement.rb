class Announcement < ActiveRecord::Base

  
  def happening_on
    
    #if end_time - start_time >  #.strftime("%I:%M %m/%d/%Y") + " - " 

    #end
    
  end
  
  def summary
    
    # Take the first two sentences of the announcement description
    description[/.+\. .+\./]
      
  end

end
