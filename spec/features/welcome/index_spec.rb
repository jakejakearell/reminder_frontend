require 'rails_helper'

describe "when a user visits the welcome page" do
  it "includes a welcome message and brief decription" do
    visit root_path

    expect(page).to have_content("Welcome to Reminder")
    expect(page).to have_content("An app to send reminders")
  end
end
