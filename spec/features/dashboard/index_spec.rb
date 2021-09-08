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

    it 'greets me and has a button that will take me to make a new reminder' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit dashboard_index_path

      expect(page).to have_content("Welcome to Reminder, junior_jimmy")
      expect(page).to have_button("New Reminder")

      click_button 'New Reminder'

      expect(current_path).to eq(new_reminder_path)
    end
  end
end
