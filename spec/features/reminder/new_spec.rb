require 'rails_helper'

describe 'as authenticated user, when I visit the new messages page' do
  describe 'happy paths' do
    before :each do
      @user = User.create(
                          email: 'james_johhny@email.com',
                          password: 'james_johhny',
                          username: 'junior_jimmy'
                        )
    end

    it 'allows me to fill in the message, start_date, end_date, time fields' do
      VCR.use_cassette("valid_message") do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

        visit new_reminder_path

        start_date = Time.now.strftime("%Y-%m-%d")
        end_date = (Time.now + 172800).strftime("%Y-%m-%d")
        time = Time.now.strftime("%H:%M")

        fill_in :end_date, with: end_date
        fill_in :start_date, with: start_date
        fill_in :time, with: time
        fill_in :message, with: "asdfadsf dasdf asd sdfasd f sdfas sdf sd asdf asdf"

        click_button 'Create Reminder'

        expect(page).to have_content("Reminder Created")

        expect(current_path).to eq(dashboard_index_path)
      end 
    end
  end

  describe 'sad paths' do
    before :each do
      @user = User.create(
                          email: 'james_johhny@email.com',
                          password: 'james_johhny',
                          username: 'junior_jimmy'
                        )
    end

    it 'will give an error if my time is empty' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit new_reminder_path

      start_date = Time.now.strftime("%Y-%m-%d")
      end_date = (Time.now + 172800).strftime("%Y-%m-%d")

      fill_in :end_date, with: end_date
      fill_in :start_date, with: start_date
      fill_in :message, with: "asdfadsf dasdf asd sdfasd f sdfas sdf sd asdf asdf"

      click_button 'Create Reminder'

      expect(page).to have_content("Must select a time, ")

      expect(current_path).to eq(reminder_index_path)
    end

    it 'will give an error if either date is empty' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit new_reminder_path

      start_date = Time.now.strftime("%Y-%m-%d")
      time = Time.now.strftime("%H:%M")

      fill_in :start_date, with: start_date
      fill_in :time, with: time
      fill_in :message, with: "asdfadsf dasdf asd sdfasd f sdfas sdf sd asdf asdf"

      click_button 'Create Reminder'

      expect(page).to have_content("Date Can't be Blank")

      expect(current_path).to eq(reminder_index_path)
    end

    it 'will give an error if my message is empty' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit new_reminder_path

      start_date = Time.now.strftime("%Y-%m-%d")
      end_date = (Time.now + 172800).strftime("%Y-%m-%d")
      time = Time.now.strftime("%H:%M")

      fill_in :end_date, with: end_date
      fill_in :start_date, with: start_date
      fill_in :time, with: time

      click_button 'Create Reminder'

      expect(page).to have_content("Message Can't be empty, ")

      expect(current_path).to eq(reminder_index_path)
    end

    it 'will create an error if end date is before start date' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit new_reminder_path

      start_date = Time.now.strftime("%Y-%m-%d")
      end_date = Time.now.strftime("%Y-%m-%d")
      time = Time.now.strftime("%H:%M")

      fill_in :end_date, with: end_date
      fill_in :start_date, with: start_date
      fill_in :time, with: time
      fill_in :message, with: "asdfadsf dasdf asd sdfasd f sdfas sdf sd asdf asdf"

      click_button 'Create Reminder'

      expect(page).to have_content("Start Date Can't be Greater than end date, ")

      expect(current_path).to eq(reminder_index_path)
    end

    it 'will let users know if multiple fields are missing' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit new_reminder_path

      click_button 'Create Reminder'

      expect(page).to have_content("Date Can't be Blank, Must select a time, Message Can't be empty,")

      expect(current_path).to eq(reminder_index_path)
    end

    it 'will not let a non-registered user access page' do
      visit new_reminder_path

      expect(page).to have_content("Please return to the welcome page and login.")
    end
  end
end
