require 'rails_helper'

describe 'as authenticated user, when I visit the new messages page' do
  it 'allows me to fill in the message, start_date, end_date, time fields' do
    visit new_reminder_path

    start_date = Time.now.strftime("%Y-%m-%d")
    end_date = Time.now.strftime("%Y-%m-%d")
    time = Time.now.strftime("%H:%M")

    fill_in :end_date, with: end_date
    fill_in :start_date, with: start_date
    fill_in :time, with: time
    fill_in :message, with: "asdfadsf dasdf asd sdfasd f sdfas sdf sd asdf asdf"

    click_button 'Create Reminder'
  end
end
