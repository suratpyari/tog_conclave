module ApplicationHelper

  def icon_for_event(event, size, options={})
    if event.icon
      photo_url = url_for_image_column(event, "icon", :name => size)
      options.merge!(:alt => "Icon for event: #{event.title}")
      return image_tag(photo_url, options) if photo_url
    end
  end
  
  private ############################
  
  def set_default_icon
    unless self.icon
      if Tog::Config["plugins.tog_conclave.event.image.default"]
        default_event_icon = File.join(RAILS_ROOT, 'public', 'tog_conclave', 'images', Tog::Config["plugins.tog_conclave.event.image.default"])
        self.icon = File.new(default_profile_icon)
      end
    end
  end
  
end
