require 'rails_helper'

describe "when a user visits the welcome page" do
  it "includes a welcome message and brief decription" do
    visit root_path

    expect(page).to have_content("Welcome to Reminder")
    expect(page).to have_content("An app to send reminders")
  end

  it "has an email and password form to sign in" do
    visit root_path

    fill_in "email", with: 'jakehy@email.com'
    fill_in "password", with: '123'

    expect(page).to have_button('Sign In')
  end

  it "includes a link for a new user to sign up and redirects you to the registration page" do
    visit root_path

    expect(page).to have_link('New to Reminder? Register Here')

    click_link('New to Reminder? Register Here')
    expect(current_path).to eq('/registration')
  end
end
