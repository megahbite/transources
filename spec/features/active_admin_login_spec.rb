require 'spec_helper'

describe "ActiveAdmin Login" do
  let(:user) { FactoryGirl.create(:user) }
  let(:superuser) { FactoryGirl.create(:superuser) }

  context "happy path" do
    it "a superuser can login to the admin interface" do
      visit '/admin/'

      fill_in 'Email', with: superuser.email
      fill_in 'Password', with: superuser.password

      click_on 'Sign in'

      expect(current_path).to eq '/admin'
    end
  end

  context 'sad path' do
    it 'a normal user cannot login to the admin interface' do
      visit '/admin/'

      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password

      click_on 'Sign in'

      expect(current_path).to eq root_path
      expect(page).to have_content 'Unauthorized access'
    end
  end
end