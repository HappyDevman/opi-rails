# README

OPI Systems specializes in grain management in bins. We have command & control devices paired with cable sensors which collect temperature and humidity from farm sites and publish them to our cloud system.

This will be an exercise to design a system to collect sensor data from cables and save those readings in a database. It will also implement a Restful API interface to access the stored data.

## System Design

A device can be connected to multiple cables, each of which has 10 sensors attached. These sensors collect temperature and humidity readings.

    +--------+ |(x) cables & (*) sensors|
    |        |x---*--*--*--*--*--*--*--*--*--*---+  
    |        |x---*--*--*--*--*--*--*--*--*--*---+  
    | Device |x---*--*--*--*--*--*--*--*--*--*---+  
    |        |x---*--*--*--*--*--*--*--*--*--*---+ 
    +---+----+  
        :                         
        |       |readings|
        +------------------------- --> CLOUD API


## Requirements

#### Task 1: Implement a `POST cable_readings` endpoint to parse and store cable readings from devices
In this phase, we want to store device and sensor data from POST requests endpoint in the CableReadingsController.

1.	Parse the data (see message format notes below).
2.	Create models to save data. A device has many cables and each cable includes 10 sensors (temperature & humidity)
3.	Data is sent for a specific device with cable readings timestamp, and should be stored accordingly.
#### Task 2: Implement an endpoint to serve "max temperature" sensor readings
In this phase, we want to surface some of the metrics that we’ve been storing. Create one endpoint which will serve max temperature for a device within a given time range.
●	The max temperature is simply the maximum temperature value detected in all sensor cables attached to the device during that time frame.
●	GET /sensor_metrics/:device_id/max_temp?start_time=ts&end_time=ts
○	    Params:
	    device_id: the ID of a device saved in our data model
	    start_time: signifies the start time of a time period (required) -- can be in whatever format you want
	    end_time: signifies the end time of a time period (required) -- can be in whatever format you want
○	    Response:
```json
{
  "max_temperature": 42.32,
  "cable_id": 8,
  "taken_at": "2021-11-29T19:09:57Z"
}
```
#### Task 3: Write a test
●	Write an rspec test for the peak_temp endpoint.

## Message Format
* DeviceId - this field refers to the hardware device on farm
* BatteryLevel - the level of the battery in percentage (0-100)
* Data - List of Cables with temp, humidity readings and timestamp


```json
{
  "device_id": 32,
  "data": [
    {
      "cable_id":1,
      "reading_timestamp": "2021-11-24T15-51-33Z",
      "temperature_reading": [16.29,27.20,20.27,27.49,12.91,17.31,85.85,29.39,19.80,98.81]
    },
    {
      "cable_id":2,
      "reading_timestamp": "2021-11-25T15-51-33Z",
      "temperature_reading": [32.27,31.99,29.12,19.20,31.55,98.59,22.75,23.95,26.55,11.04]
    }
  ],
  "publishedAt": "2021-11-25T15-51-33Z"
}
```


### Sensor Event publisher script:

Run the following bash script to publish events to cable_readings/events endpoint to generate mock data:

```sh
curl --location --request POST 'http://localhost:3000/cable_readings' \
--header 'Content-Type: application/json' \
--data-raw '{
  "deviceId": 32,
  "data": [
    {
      "cable_id":1,
      "reading_timestamp": "2021-11-24T15-51-33Z",
      "temperature_reading": [16.29,27.20,20.27,27.49,12.91,17.31,85.85,29.39,19.80,98.81]
    },
    {
      "cable_id":2,
      "reading_timestamp": "2021-11-25T15-51-33Z",
      "temperature_reading": [32.27,31.99,29.12,19.20,31.55,98.59,22.75,23.95,26.55,11.04]
    }
  ],
  "publishedAt": "2021-11-25T15-51-33Z"
}'
```

### Prerequisites:

- ruby 
- rails
- project setup to work with sqlite by default. Switch it with postgres if you prefer.


### Setup steps:

```sh
unzip the repo opi-rails-assignmet.zip
cd opi-rails-assignment
bundle

```

### Check that things work:

1. Check the server/endpoint:

```sh
rails s
bundle exec rspec
```

## Evaluation Criteria

The primary thing we are looking for is how well your code would work in our team environment. To that end, we are looking at:
- maintainability
- consistent style
- proper separation of concerns
- bug free
- easy to understand

## Submission
- Make sure you have completed all tasks
- If you had made any assumptions on the requirments, declare them explicity in the code using comments
- Upload the code to your personal git repository and email back the link
