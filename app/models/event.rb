class Event < ActiveRecord::Base
  
  include GG
  acts_as_taggable
  seo_urls
  belongs_to :owner, :class_name =>'User', :foreign_key =>'user_id'
  has_many   :attendances,      :dependent => :destroy
  has_many   :attendees,        :through => :attendances, :source => :user
  
  validates_presence_of :title, :description, :venue
  
  def validate
    loc = gg.locate self.venue_address rescue nil
    errors.add("venue_address", "Event Address not found on map") if loc.nil?
    errors.add("start_date", "is not valid") if self.start_date < Date.today
    errors.add("end_date", "is not valid") if self.end_date < self.start_date 
  end
  
#  before_create :set_default_icon

#  file_column :icon, :root_path => File.join(RAILS_ROOT, "public/system/event"), :web_root => 'system/event/', :magick => {
 #   :versions => {
  #    :big    => {:crop => "1:1", :size => Tog::Config["plugins.tog_conclave.event.image.versions.big"], :size => "200x200",    :name => "big"},
   #   :medium => {:crop => "1:1", :size => Tog::Config["plugins.tog_conclave.event.image.versions.medium"], :size => "150x150!", :name => "medium"},
    #  :small  => {:crop => "1:1", :size => Tog::Config["plugins.tog_conclave.event.image.versions.small"], :size => "100x100!",  :name => "small"},
     # :tiny   => {:crop => "1:1", :size => Tog::Config["plugins.tog_conclave.event.image.versions.tiny"], :size => "50x50!",   :name => "tiny"}
#    }
 # }

  
  def register(user)
    att = Attendance.find(:first, :conditions => ["user_id = ? and event_id = ?", user.id, self.id])   

    if att.nil?
      registration = Attendance.new
      registration.event = self
      registration.user = user
      registration.save
      return true
    else
      return false
    end
  end
  
  def unregister(user)
    Attendance.delete_all( ["user_id = ? and event_id = ?", user.id, self.id])
  end
  
  def opening_time
    result = "From #{self.start_date.strftime('%m/%d/%Y')} #{self.start_time.strftime('%H:%m')}" 
    result << " to #{self.end_date.strftime('%m/%d/%Y')} #{self.end_time.strftime('%H:%m')}"
    result
  end
  
  def available_capacity
    if(self.capacity)
      return self.capacity - self.attendances.size
    else
      return 0
    end
  end
  
  
  
end
