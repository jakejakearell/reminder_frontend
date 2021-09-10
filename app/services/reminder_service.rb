class ReminderService
  def self.post_reminder(reminder)
    response = conn.post('/api/v1/reminder') do |request|
      request.headers['Content-Type'] = 'application/json'
      request.body = reminder.to_json
    end
  end

  private

  def self.conn
    Faraday.new(url: 'http://localhost:3000')
  end
end
