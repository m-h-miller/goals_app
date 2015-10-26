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
  end
end
