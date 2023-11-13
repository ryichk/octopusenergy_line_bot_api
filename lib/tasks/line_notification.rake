namespace :line_notification do
  desc 'LINEに昨日の電気使用量・料金を通知する'
  task send_electricity_usage_and_cost_of_yesterday: :environment do
    LineNotification.send_electricity_usage_and_cost_of_yesterday
  end
end
