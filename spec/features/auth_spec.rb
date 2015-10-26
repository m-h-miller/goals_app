require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

    before :each do
      visit new_user_url
    end

    scenario "new user page" do
      expect(page).to have_content "Sign Up"
    end

    scenario "username and password" do
      expect(page).to have_content "Username"
      expect(page).to have_content "Password"
    end

    feature "signing up a user" do

      it "shows username on the homepage after signup" do
        sign_up('BobbyTables', 'BobbyTables')

        expect(page).to have_content "BobbyTables"
      end

      scenario "validates password presence" do
        sign_up("BobbyTables", "")
        expect(page).to have_content("Password is too short")
      end

      scenario "validates name presence" do
        sign_up("", "password")
        expect(page).to have_content("Username can't be blank")
      end

      scenario "validates password length" do
        sign_up("BobbyTables", "bobby")
        expect(page).to have_content("Password is too short")
      end
    end

end

feature "logging in" do

  before :each do
    visit new_user_url
    sign_up('BobbyTables', 'BobbyTables')

    visit new_session_url
  end

  it "shows username on the homepage after login" do
    sign_in('BobbyTables', 'BobbyTables')
    expect(page).to have_content("BobbyTables")
  end

  it "rejects invalid credentials" do
    sign_in('BobbyTables', 'abcdef')
    expect(page).to have_content('Invalid Credentials')
  end

end

feature "logging out" do

  it "begins with logged out state"

  it "doesn't show username on the homepage after logout"

end
