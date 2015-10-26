require 'spec_helper'
require 'rails_helper'

feature 'create goals' do

  before :each do
    visit new_user_url
    sign_up('BobbyTables', 'BobbyTables')
    bobby = User.first
    visit new_goal_url(bobby.id)
  end

  scenario 'new goal page' do
    expect(page).to have_content("Submit New Goal")
  end

  scenario 'new goal page parameters' do
    expect(page).to have_content("Title")
    expect(page).to have_content("Description")
    expect(page).to have_content("Private?")
  end

  it 'displays goal details after submitting' do
    create_goal('Goal1', 'Get in shape', 'Public')
    expect(page).to have_content('Goal1')
    expect(page).to have_content('Get in shape')
    expect(page).to have_content('BobbyTables')
  end
end

feature 'privacy' do
  before :each do
    visit new_user_url
    sign_up('BobbyTables', 'BobbyTables')
    bobby = User.first
    visit new_goal_url(bobby.id)
    create_goal('Goal1', 'Get in shape', 'Private')
    click_button('Sign Out')
    visit new_user_url
    sign_up('HarryStyles', 'password')
    harry= User.last
    visit goals_url
  end

  it "doesn't display private goals on index" do
    expect(page).not_to have_content("Goal1")
  end

  it "does display private goals of current user" do
    click_button('Sign Out')
    sign_in('BobbyTables', 'BobbyTables')
    visit goals_url
    expect(page).to have_content("Goal1")
  end

  it "doesn't allow direct access to an unowned goal" do
    visit goal_url(Goal.first)
    expect(page).to have_content("Permission denied")
  end
end

feature 'edit' do
  before :each do
    visit new_user_url
    sign_up('BobbyTables', 'BobbyTables')
    bobby = User.first
    visit new_goal_url(bobby.id)
    create_goal('Goal1', 'Get in shape', 'Private')
  end

  it 'shows an edit button for an owned goal' do
    expect(page).to have_content("Edit Goal")
  end

  it 'saves the updated data' do
    click_link("Edit Goal")
    fill_in("Title", with: "new title")
    click_button "Edit Goal"
    expect(page).to have_content("new title")
  end
end
