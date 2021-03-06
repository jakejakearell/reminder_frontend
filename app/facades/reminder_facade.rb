require 'json'

class ReminderFacade
  attr_reader :errors

  def initialize(params, user)
    @params = params
    @user = user
    @errors = ""
  end

  def valid?
    if check_all_valid
      ReminderService.post_reminder(serializer_reminder)
      true
    else
      false
    end
  end

  def serializer_reminder
    ReminderSerializer.new(open_struct_object)
  end

  def open_struct_object
    OpenStruct.new({id: nil,
                    user_id: @user.id,
                    email: @user.email,
                    start_date: @params[:start_date],
                    end_date: @params[:end_date],
                    time: @params[:time],
                    message: @params[:message]
                    })
  end

  def check_all_valid
    checks = [valid_date?, valid_time?, valid_message?]
    checks.all? { |check| check == true}
  end

  def valid_date?
    start_date = @params[:start_date]
    end_date = @params[:end_date]
    if start_date.empty? || end_date.empty?
      @errors += "Date Can't be Blank, "
      false
    elsif Date.parse(start_date) >= Date.parse(end_date)
      @errors += "Start Date Can't be Greater than end date, "
      false
    else
      true
    end
  end

  def valid_time?
    if @params[:time].empty?
      @errors += "Must select a time, "
      false
    else
      true
    end
  end

  def valid_message?
    if @params[:message].empty?
      @errors += "Message Can't be empty, "
      false
    else
      true
    end
  end
end
