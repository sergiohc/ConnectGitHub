namespace :schema do
  desc "Update GitHub GraphQL schema"
  task :update do
    GraphQL::Client.dump_schema(ConnectGitHub::HTTP, "db/schema.json")
  end
end