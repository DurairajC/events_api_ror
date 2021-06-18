class Api::V1::EventsController < ApplicationController

  def index
    @events = Event.all
    render json: @events
  end

  def show
    @event = Event.find(params[:id])
    render json: @event
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      render json: @event
    else
      render error: {error: "unable to create event"}, status: 400
    end
  end

  def update
    @event = Event.find(params[:id])
    if @event
      @event.update(event_params)
      render json: {message: "Event succesfully updated."}, status: 200
    else
      render error: {error: "unable to update event"}, status: 400
    end
  end

  def destroy
    @event = Event.find(params[:id])
    if @event
      @event.destroy
      render json: {message: "Event succesfully deleted."}, status: 200
    else
      render error: {error: "unable to delete event"}, status: 400
    end
  end

  def find_by_repo
    @event = Event.find_by_repo_id(params[:id])
    if @event
      render json: @event
    else
      render error: {error: "unable to find repo_id"}, status: 400
    end
  end

  private

  def event_params
    params.permit(:event_type, :public, :repo_id, :actor_id)
  end

end