# frozen_string_literal: true

require 'rails_helper'

describe CableReadingsController do
  describe 'POST create' do
    let(:params) do
      {
        device_id: 32,
        data: [
          {
            cable_id: 1,
            reading_timestamp: "2021-11-24T15-51-33Z",
            temperature_reading: [16.29,27.20,20.27,27.49,12.91,17.31,85.85,29.39,19.80,98.81]
          },
          {
            cable_id: 2,
            reading_timestamp: "2021-11-25T15-51-33Z",
            temperature_reading: [32.27,31.99,29.12,19.20,31.55,98.59,22.75,23.95,26.55,11.04]
          }
        ],
        publishedAt: "2021-11-25T15-51-33Z"
      }
    end

    subject(:request) do
      post :create, params: params, format: :json
    end

    it 'returns with created' do
      request
      expect(response).to have_http_status(:created)
    end

    it 'creates a device' do
      expect { request }.to change(Device, :count).by(1)
    end

    it 'creates cables' do
      expect { request }.to change(Cable, :count).by(2)
    end
  end
end
