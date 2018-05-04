require_relative "boot"

require "rails/all"
require "graphql/client"
require "graphql/client/http"
require "active_record/railtie"
require "action_cable/engine"

Bundler.require(*Rails.groups)

# Star Wars API example wrapper
module ConnectGitHub
  class Application < Rails::Application
  end
  # Configure GraphQL endpoint using the basic HTTP network adapter.
  HTTP = GraphQL::Client::HTTP.new("https://api.github.com/graphql") do
    def headers(context)
      unless token = context[:access_token] || Application.secrets.github_access_token
      # Optionally set
       any HTTP headers
      fail "Missing GitHub access token"
    end

    {
      "Authorization" => "Bearer #{token}"
    }
    end
  end  

  # Fetch latest schema on init, this will make a network request
  Schema = GraphQL::Client.load_schema(HTTP)
  # However, it's smart to dump this to a JSON file and load from disk
  #
  # Run it from a script or rake task
  #GraphQL::Client.dump_schema(ConnectGitHub::HTTP, "db/schema.json")
  #
  # Schema = GraphQL::Client.load_schema("path/to/schema.json")

  Client = GraphQL::Client.new(schema: Schema, execute: HTTP)
end