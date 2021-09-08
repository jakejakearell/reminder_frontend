class ReminderController < ApplicationController
  before_action :require_current_user

  def new;end

  def create
    reminder =  ReminderFacade.new(reminder_params, current_user)
    if reminder.valid?
      flash[:notice] = "Reminder Created!"
      redirect_to :dashboard_index
    else
      flash[:message] = reminder.errors
      render :new
    end
  end

  private

  def require_current_user
    render file: '/public/401' unless current_user
  end

  def reminder_params
    params.permit(:start_date, :end_date, :time, :message)
  end
end
