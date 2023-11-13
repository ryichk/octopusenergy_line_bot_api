# Octopus Energy LINE Bot API

## Description

Send yesterday's electricity usage and cost to LINE using [Octopus Energy's GraphQL API](https://developer.octopus.energy/docs/api/#graphql-api).

## Setting

1. Copy .env.sample file to create .env file.

2. Set the email, password, and account number for your Octopus Energy account in the .env file.

3. Please refer to [this article](https://qiita.com/KNR109/items/e1b5ebd94393441fff74#messaging-api-%E3%81%AE%E3%83%81%E3%83%A3%E3%83%8D%E3%83%AB%E3%81%AE%E4%BD%9C%E6%88%90) to create a channel for LINE's Messaging API.

4. Once you have created a channel for LINE's Messaging API, set the channel secret and channel access token in the .env file.

## Execute

```sh
bin/rails line_notification:send_electricity_usage_and_cost_of_yesterday
```
