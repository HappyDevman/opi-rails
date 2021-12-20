require 'rails_helper'

RSpec.describe Cable, type: :model do
  describe 'Model relation' do
    it { is_expected.to belong_to(:device) }
  end

  describe 'Model validations' do
    it { is_expected.to validate_presence_of(:cable_id) }
  end
end
