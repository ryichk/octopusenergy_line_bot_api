class LineNotification
  GET_BILL_QUERY = ::Octopus::CLIENT.parse <<~GRAPHQL
    query($accountNumber: String!, $fromDatetime: DateTime, $toDatetime: DateTime) {
      account(accountNumber: $accountNumber) {
        properties {
          electricitySupplyPoints {
            agreements {
              validFrom
            }
            halfHourlyReadings(fromDatetime: $fromDatetime, toDatetime: $toDatetime) {
              startAt
              endAt
              value
              costEstimate
              consumptionStep
              consumptionRateBand
            }
          }
        }
      }
    }
  GRAPHQL

  def self.send_electricity_usage_and_cost_of_yesterday
    result = ::Octopus::CLIENT.query(GET_BILL_QUERY, variables: {
      accountNumber: ENV['OCTOPUS_ACCOUNT_NUMBER'],
      fromDatetime: Time.zone.yesterday.beginning_of_day.iso8601,
      toDatetime: Time.zone.yesterday.end_of_day.iso8601
    })
    properties = result.original_hash.dig('data', 'account', 'properties')
    electricity_supply_points = properties.first['electricitySupplyPoints']
    half_hourly_readings = electricity_supply_points.first['halfHourlyReadings']
    kwh = half_hourly_readings.pluck('value').map(&:to_f).sum
    cost = half_hourly_readings.pluck('costEstimate').map(&:to_f).sum
    text = "#{Time.zone.yesterday.strftime('%Y年%m月%d日')}は#{kwh.round(2)}kWh消費して#{cost}円かかったよ"
    message = {
      type: 'text',
      text: text
    }
    LineBot.client.broadcast(message)
  end
end
