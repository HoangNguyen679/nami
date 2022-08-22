# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserDecorator do
  subject { user }

  let(:user) { create(:user).extend UserDecorator }

  describe '#name' do
    it 'returns full name' do
      expect(user.name).to eq "#{user.first_name} #{user.last_name}"
    end
  end

  describe '#profile_picture_url' do
    it 'returns a gravatar URL' do
      expect(user.profile_picture_url).to start_with 'https://www.gravatar.com'
    end
  end
end
