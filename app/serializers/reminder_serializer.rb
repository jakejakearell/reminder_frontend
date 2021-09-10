class ReminderSerializer
  include FastJsonapi::ObjectSerializer
  attributes :time, :start_date, :end_date, :message

end
