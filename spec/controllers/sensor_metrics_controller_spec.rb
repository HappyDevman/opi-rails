# frozen_string_literal: true

require 'rails_helper'

describe SensorMetricsController do
  describe 'GET /sensor_metrics/:device_id/max_temp' do
    let(:device) { create(:device) }
    let(:cable1) { create(:cable, device: device, reading_timestamp: 2.weeks.ago, temperature_reading: [20.1, 31.2]) }
    let(:cable2) { create(:cable, device: device, reading_timestamp: 1.week.ago, temperature_reading: [19.1, 35.5]) }

    subject(:request) do
      get :max_temp, params: params, format: :json
    end

    context 'without start or end time' do
      let(:params) do
        {
          device_id: device.id,
          start_time: 1.month.ago
        }
      end

      it 'respond with error' do
        subject
        expect(response).to have_http_status(:bad_request)
        expect(json['message']).to eq('start_time and end_time should be provided')
      end
    end

    context 'with incorrect time range' do
      let(:params) do
        {
          device_id: device.id,
          start_time: 1.month.ago,
          end_time: 3.weeks.ago
        }
      end

      it 'respond a message with success' do
        subject
        expect(response).to have_http_status(:ok)
        expect(json['message']).to eq('Can\'t find data in given time range')
      end
    end

    context 'with correct time range' do
      let(:params) do
        {
          device_id: device.id,
          start_time: 1.month.ago,
          end_time: Time.zone.now
        }
      end

      before do
        cable1
        cable2
      end

      it 'respond data with success' do
        subject
        expect(response).to have_http_status(:ok)
        expect(json).to eq({
                             "max_temperature" => 35.5,
                             "cable_id" => cable2.cable_id,
                             "taken_at" => cable2.reading_timestamp.iso8601
                           })
      end
    end
  end
end
