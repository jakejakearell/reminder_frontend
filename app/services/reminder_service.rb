class ReminderService 
  private
  def conn
    Faraday.new(url: 'localhost:3000')
  end
end
