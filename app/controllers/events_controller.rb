class EventsController < ApplicationController
	before_filter :find_event, :only => [:show,:edit,:update,:destroy]
	
	def index
		@events = Event.page(params[:page]).per(5)
		respond_to do |format|
			format.html #index.html.erb
			format.xml # show.xml.builder
			   format.json { render :json => @events.to_json }
			format.atom { @feed_title = "My event list"}
		end
	end
	def new
	 @event = Event.new
	 end
	 
	 def create 
	 @event = Event.new(params[:event])
	 if @event.save
		flash[:notice] = "event was successfully created"
		redirect_to events_url
	 else
		render :action=>:new
	 end

	 end
	 def show
	 @results = GoogleCustomSearchApi.search("google") 
	 @page_title = @event.name
	
	 end
	 def edit
	 
	 end
	 def update
		if @event.update_attributes(params[:event])
			flash[:notice] = "event was successfully updated"
			redirect_to event_url(@event)
		else
			render :action =>:edit
		end
	 end
	 def destroy
		flash[:alert] = "event was successfully deleted"
		@event.destroy

		redirect_to events_url
	end
	
	protected
	def find_event
		@event = Event.find(params[:id])
	end
end
