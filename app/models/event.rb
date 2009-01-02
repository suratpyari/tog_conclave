class Event < ActiveRecord::Base
  include FileColumn
  include GG
  acts_as_taggable
  seo_urls
  belongs_to :owner, :class_name =>'User', :foreign_key =>'user_id'
  has_many   :attendances,      :dependent => :destroy
  has_many   :attendees,        :through => :attendances, :source => :user
  
  validates_presence_of :title, :description, :venue
  validates_image_size :icon, :max => '50x50', :min => '30x30'
  def validate
    loc = gg.locate self.venue_address rescue nil
    errors.add("venue_address", "Event Address not found on map") if loc.nil?
    errors.add("start_date", "is not valid") if self.start_date < Date.today
    errors.add("end_date", "is not valid") if self.end_date < self.start_date 
  end
  before_create :set_default_icon
  file_column :icon, :root_path => File.join(RAILS_ROOT, "public/system/event"), :web_root => 'system/event/', :magick => {:versions => {:big => {:name => "big"}}}
                    
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
    result = "From #{self.start_date.strftime('%d %b, %Y at %I:%M%p')}" 
    result << " to #{self.end_date.strftime('%d %b, %Y at %I:%M%p')}"
    result
  end
  
  def available_capacity
    if(self.capacity)
      return self.capacity - self.attendances.size
    else
      return 0
    end
  end

  def set_default_icon
    unless self.icon
      if Tog::Config["default_event.png"]
        default_profile_icon = File.join(RAILS_ROOT, 'public', 'tog_conclave', 'images', Tog::Config["default_event.png"])
        self.icon = File.new(default_profile_icon)
      end
    end
  end
  
end
