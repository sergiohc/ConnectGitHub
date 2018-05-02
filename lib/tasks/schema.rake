namespace :schema do
  desc "Update GitHub GraphQL schema"
  task :update do
    GraphQL::Client.dump_schema(GitHub::HTTPAdapter, "db/schema.json")
  end
end