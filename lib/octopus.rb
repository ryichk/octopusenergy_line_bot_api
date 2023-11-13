require 'graphql/client'
require 'graphql/client/http'

module Octopus
  API_URI = 'https://api.oejp-kraken.energy/v1/graphql/'
  HTTP = GraphQL::Client::HTTP.new(API_URI) do
    def headers(context)
      { 'Authorization': OctopusAuth.token }
    end
  end
  SCHEMA = GraphQL::Client.load_schema(HTTP)
  CLIENT = GraphQL::Client.new(schema: SCHEMA, execute: HTTP)
end
