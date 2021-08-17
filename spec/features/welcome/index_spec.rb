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

  describe "I see a form to log in" do
   before :each do
     @user = User.create(
                         email: 'james_johhny@email.com',
                         password: 'james_johhny',
                         username: 'junior_jimmy'
                       )
   end

   it "when a user signs in with valid credentials it takes user to their dashboard" do
     visit root_path

     fill_in "email", with: 'james_johhny@email.com'
     fill_in "password", with: 'james_johhny'

     click_button "Sign In"

     expect(current_path).to eq(dashboard_index_path)
     expect(page).to have_content("Welcome to Reminder, #{@user.username}")
   end

   it "when a user signs in with an incorrect password it returns the user to the welcome page" do
     visit root_path

     fill_in "email", with: @user.email
     fill_in "password", with: 'garrison'

     click_button "Sign In"

     expect(current_path).to eq(root_path)
     expect(page).to have_content("The email or password you entered is incorrect")
   end

   it "when a user signs in with an incorrect email it returns the user to the welcome page" do
     visit root_path

     fill_in "email", with: "iam_not_harrison@garrison.com"
     fill_in "password", with: 'harrison'

     click_button "Sign In"

     expect(current_path).to eq(root_path)
     expect(page).to have_content("The email or password you entered is incorrect")
   end
 end

 describe "If I am already logged in I see" do
   before :each do
     @user = User.create(
                         email: 'james_johhny@email.com',
                         password: 'james_johhny',
                         username: 'junior_jimmy'
                       )
   end

   it "a link to the Dashboard and do not see a link to Register" do
     allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

     visit root_path

     expect(page).to_not have_button("Sign In")
     expect(page).to have_link("Dashboard")
     expect(page).to_not have_link('New to Reminder? Register Here')
   end

   it "a link to logout, when clicked I am back on the welcome page and see a login form again" do
     visit root_path

     fill_in "email", with: 'james_johhny@email.com'
     fill_in "password", with: 'james_johhny'

     expect(page).to_not have_link('Logout')
     expect(page).to have_button('Sign In')
     click_button 'Sign In'

     expect(page).to have_button('Logout')

     click_button 'Logout'

     expect(current_path).to eq(root_path)
     expect(page).to have_button('Sign In')
   end
  end
end
