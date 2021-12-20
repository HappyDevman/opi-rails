# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'cable_readings', to: 'cable_readings#create'
  get '/sensor_metrics/:device_id/max_temp', to: 'sensor_metrics#max_temp'
end
