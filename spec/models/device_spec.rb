require 'rails_helper'

RSpec.describe Device, type: :model do
  describe 'Model relation' do
    it { is_expected.to have_many(:cables) }
  end

  describe 'Model validations' do
    it { is_expected.to validate_presence_of(:device_id) }
  end
end
