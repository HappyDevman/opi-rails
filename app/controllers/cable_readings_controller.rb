# frozen_string_literal: true

class CableReadingsController < ApplicationController
  def create
    device = Device.create!(device_params.except(:data, :publishedAt).merge(published_at: valid_time(device_params[:publishedAt])))
    device_params[:data].each do |data|
      valid_readtime = valid_time(data[:reading_timestamp])
      device.cables.create!(data.merge(reading_timestamp: valid_readtime))
    end
    json_response({ status: 'received' }, :created)
  end

  private

  def valid_time(datetime)
    datetime.split('T').map.with_index { |e, i| i == 1 ? e.gsub('-', ':') : e }.join('T')
  end

  def device_params
    params.permit(:device_id, :battery_level, :publishedAt, data: [
      :cable_id, :reading_timestamp, temperature_reading: [], humidity_reading: []
    ])
  end
end
