# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RewardsController, type: :controller do
  let(:user) { create(:user) }
  let(:rewards) { create_list(:reward, 3, user: user) }

  before { login(user) }

  describe 'GET #index' do
    it 'renders a rewards' do
      get :index

      expect(assigns(:rewards)).to match_array(rewards)
    end
  end
end
