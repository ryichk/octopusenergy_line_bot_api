require 'graphql/client'
require 'graphql/client/http'

module OctopusAuth
  HTTP = GraphQL::Client::HTTP.new(Octopus::API_URI)
  SCHEMA = GraphQL::Client.load_schema(HTTP)
  CLIENT = GraphQL::Client.new(schema: SCHEMA, execute: HTTP)
  LOGIN_QUERY = CLIENT.parse <<~GRAPHQL
    mutation($input: ObtainJSONWebTokenInput!) {
      obtainKrakenToken(input: $input) {
        token
        refreshToken
      }
    }
  GRAPHQL

  def self.token
    result = CLIENT.query(LOGIN_QUERY, variables: {
      input: {
        email: ENV['OCTOPUS_EMAIL'],
        password: ENV['OCTOPUS_PASS']
      },
    })
    result.original_hash.dig('data', 'obtainKrakenToken', 'token')
  end
end
