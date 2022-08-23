# frozen_string_literal: true

require 'rails_helper'
describe 'Posting' do
  let(:user) { create(:user) }
  let(:status_text) { 'Whohoo!' }

  def sign_in(user)
    visit new_user_session_path
    fill_in 'Username / Email', with: user.username
    fill_in 'Password', with: user.password
    click_on 'Log in'
  end

  it 'Posting a status' do
    sign_in user

    expect do
      fill_in 'post_status_text', with: status_text
      click_on 'Say'
    end.to change { user.reload.posts.count }.from(0).to(1)

    posted_status = user.posts.first.postable

    expect(posted_status.text).to eq status_text
    expect(page).to have_content status_text
    within('.line .content') do
      expect(page).not_to have_selector('img')
    end
  end

  it 'Posting a status with a picture' do
    sign_in user
    expect do
      fill_in 'post_status_text', with: status_text
      attach_file 'picture_files', Rails.root.join('app/assets/images/fox.jpg'), visible: false
      click_on 'Say'
    end.to change { user.reload.posts.count }.from(0).to(1)

    expect(page).to have_content status_text

    within('.line .content') do
      expect(page).to have_selector('.pictures')
      expect(page).to have_selector('img', count: 1)
    end
  end

  it 'Posting a status with multiple pictures' do
    sign_in user
    expect do
      fill_in 'post_status_text', with: status_text
      attach_file 'picture_files', [
        Rails.root.join('app/assets/images/fox.jpg'),
        Rails.root.join('app/assets/images/lgtm.jpeg'),
      ], visible: false
      click_on 'Say'
    end.to change { user.reload.posts.count }.from(0).to(1)

    within('.line .content') do
      expect(page).to have_selector('img', count: 2)
    end
  end
end
