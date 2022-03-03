# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reward, type: :model do
  it { should belong_to :rewardable }

  it { should validate_presence_of :name }
end
