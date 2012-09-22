class Announcement < ActiveRecord::Base

  belongs_to :user
  has_and_belongs_to_many :tags

  attr_accessor :tag_string

  attr_protected :is_approved

  before_save :save_tags

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

  def get_tag_string
    tag_names = []

    tags.each do |tag|
      tag_names << tag.name
    end

    tag_names.join(", ")
  end

  def save_tags
    if(tag_string != nil)
      self.tags = []  # remove current tags so that list can reflect removed items
      tag_names = tag_string.split(",")

      tag_names.each do |tag_name|
        tag_name.strip!
        tag_name.downcase!

        if((t = Tag.find_by_name(tag_name)) == nil)
          t = Tag.new
          t.name = tag_name
          t.save
        end

        if(t != nil && !self.tags.include?(t))
          self.tags << t
        end
      end
    end
  end

  def html_description
    # Escape description input to prevent XSS attacks
    d = CGI.escapeHTML(self.description)
    
    paragraphs = []

    if d != nil
      # check for Windows-style newlines first
      if d.scan(/\r\n/).length > 0
        paragraphs = d.split(/\r\n/)
      # then check for Unix-style newlines
      elsif d.scan(/\n/).length > 0
        paragraphs = d.split(/\n/)
      # then check for Mac-style newlines
      elsif d.scan(/\r/).length > 0
        paragraphs = d.split(/\r\n/)
      else
        paragraphs << d
      end
    end

    paragraphs = '<p>' + paragraphs.join('</p><p>') + '</p>'
    
    #use regex to detect url's and wrap them in an <a> tag
    paragraphs.gsub!(/(?i)\b((?:[a-z][\w-]+:(?:\/{1,3}|[a-z0-9%])|www\d{0,3}[.]|[a-z0-9.\-]+[.][a-z]{2,4}\/)(?:[^\s()<>]+|\(([^\s()<>]+|(\([^\s()<>]+\)))*\))+(?:\(([^\s()<>]+|(\([^\s()<>]+\)))*\)|[^\s`!()\[\]{};:'".,<>?«»“”‘’]))/, '<a href="\0">\0</a>')
    
    # add in http:// if missing from anchor href
    paragraphs.gsub!(/<a href="([^(https?:\/\/)])/, '<a href="http://\1')

    return paragraphs
  end
end
