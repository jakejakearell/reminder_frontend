class ReminderFacade
  def initialize(params, user)
    @params = params
    @user = user
  end

  def save
  end

  def valid?
    if valid_date? && valid_time? && valid_message?
      true
    else
      false
    end
  end

  def valid_date?
    start_date = @params[:start_date]
    end_date = @params[:end_date]

    if start_date.empty? || end_date.empty?
      false
    elsif Date.parse(start_date) >= Date.parse(end_date)
      false
    else
      true
    end
  end

  def valid_time?
    !@params[:time].empty? ? true : false
  end

  def valid_message?
    !@params[:message].empty? ? true : false
  end
end
