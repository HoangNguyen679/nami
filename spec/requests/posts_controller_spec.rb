# frozen_string_literal: true

require 'rails_helper'

describe PostsController do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe 'POST /posts' do
    context 'when posting a status update' do
      it 'can post the status if all data is valid' do
        expect do
          post '/posts', params: {
            post: {
              postable_type: 'Status',
              status_text: 'Howdy!'
            }
          }
        end.to change {
          user.posts.reload.count
        }.from(0).to(1)

        expect(response).to redirect_to(timelines_path)
        follow_redirect!
        expect(response.body).to include 'Howdy!'
      end
    end
  end
end
