require 'spec_helper'
require 'rails_helper'

feature 'user comments' do

  before :each do
    visit new_user_url
    sign_up('BobbyTables', 'BobbyTables')
    bobby = User.first
    click_button("Sign Out")
    visit new_user_url
    sign_up("HarryStyles", "password")
    visit user_url(bobby)
  end

  it 'allows users to comment on other users' do
    fill_in('Comment', with: "keep it up~=!")
    click_button('Submit comment')
    expect(page).to have_content("keep it up~=!")
  end

end
