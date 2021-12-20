class SensorMetricsController < ApplicationController
  def max_temp
    unless params[:start_time].present? && params[:end_time].present?
      json_response({ message: 'start_time and end_time should be provided' }, :bad_request) and return
    end
    device = Device.find(params[:device_id])
    max_temp_cable = device.cables.where(reading_timestamp: Time.parse(params[:start_time])..Time.parse(params[:end_time]))
                           .sort_by { |e| e.temperature_reading.max }.last
    if max_temp_cable
      json_response({
                      max_temperature: max_temp_cable.temperature_reading.max,
                      cable_id: max_temp_cable.cable_id,
                      taken_at: max_temp_cable.reading_timestamp.iso8601
                    }, :ok)
    else
      json_response({ message: 'Can\'t find data in given time range' }, :ok)
    end
  end
end
