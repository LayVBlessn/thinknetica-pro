# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Link, type: :model do
  it { should belong_to :linkable }

  it { should validate_presence_of :name }
  it { should validate_presence_of :url }

  describe 'Model methods' do
    let!(:answer) { create(:answer) }
    let(:link) do
      create(:link, linkable: answer, url: 'https://gist.github.com/LayVBlessn/681d0316da444f358ea4ba96f34323da')
    end
    let(:link_two) { create(:link, linkable: answer, url: 'https://vk.com') }

    it 'should check is link a gist or not' do
      expect(link).to be_is_gist
      expect(link_two).to_not be_is_gist
    end
  end
end
