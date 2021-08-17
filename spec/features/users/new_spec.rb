require 'rails_helper'

describe "When a user visits the registration path" do
  describe "there is a form with email, username password & confirmation" do
    describe "happy paths" do
      it "and I can create a user when I enter valid information" do
        visit registration_path

        fill_in "user[email]", with: "bigdog@woof.com"
        fill_in "user[username]", with: "big_dawg"
        fill_in "user[password]", with: "456tuff"
        fill_in "user[password_confirmation]", with: "456tuff"
        click_button "Register"

        expect(current_path).to eq(dashboard_index_path)
        expect(page).to have_content("Welcome to Reminder, big_dawg")
      end
    end

    describe 'sad paths' do
      it "and I cannot create user without a valid email" do
        visit registration_path

        fill_in "user[email]", with: "somestuff"
        fill_in "user[password]", with: "456tuff"
        fill_in "user[password_confirmation]", with: "456tuff"
        click_button "Register"

        expect(current_path).to eq(users_path)
        expect(page).to have_content("Email is invalid")
      end

      it "and I cannot create user without an email" do
        visit registration_path

        fill_in "user[username]", with: "big_dawg"
        fill_in "user[password]", with: "456tuff"
        fill_in "user[password_confirmation]", with: "456tuff"
        click_button "Register"

        expect(current_path).to eq(users_path)
        expect(page).to have_content("Email can't be blank, and Email is invalid")
      end

      it "and I cannot create user without an username" do
        visit registration_path

        fill_in "user[email]", with: "bigdog@woof.com"
        fill_in "user[password]", with: "456tuff"
        fill_in "user[password_confirmation]", with: "456tuff"
        click_button "Register"

        expect(current_path).to eq(users_path)
        expect(page).to have_content("Username can't be blank")
      end

      it "and I cannot create user without an password" do
        visit registration_path

        fill_in "user[email]", with: "bigdog@woof.com"
        fill_in "user[username]", with: "big_dawg"

        click_button "Register"

        expect(current_path).to eq(users_path)
        expect(page).to have_content("Password can't be blank")
      end

      it "and I cannot create user without an accurate password confirmation" do
        visit registration_path

        fill_in "user[email]", with: "some@stuff.com"
        fill_in "user[username]", with: "big_dawg"
        fill_in "user[password]", with: "456tuff"
        fill_in "user[password_confirmation]", with: "123tuff"
        click_button "Register"

        expect(current_path).to eq(users_path)
        expect(page).to have_content("Password confirmation doesn't match")
      end
    end
  end
end
