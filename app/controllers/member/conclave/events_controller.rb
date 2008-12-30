class Member::Conclave::EventsController < Member::BaseController
  
  def index
    @events = current_user.events.paginate :per_page => 100, :page => (params[:page] || '1')
    render :template => "/conclave/events/index"
  end
    
  def register
    @event = Event.find(params[:id])
    @event.register(current_user)
    flash[:ok] = I18n.t("tog_conclave.member.registered", :title => @event.title)
    redirect_to(conclave_event_path(@event))
  end
  
  def unregister
    @event = current_user.events.find(params[:id])
    @event.unregister(current_user)
    flash[:ok] = I18n.t("tog_conclave.member.unregistered", :title => @event.title)
    redirect_to(conclave_event_path(@event))
  end
  
end
