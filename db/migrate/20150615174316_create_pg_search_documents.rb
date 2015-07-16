class CreatePgSearchDocuments < ActiveRecord::Migration
#   def self.up
#     say_with_time("Creating table for pg_search multisearch") do
#       create_table :pg_search_documents do |t|
#         t.text :content
#         t.belongs_to :searchable, :polymorphic => true, :index => true
#         t.timestamps null: false
#       end
#     end
#   end
#
#   def self.down
#     say_with_time("Dropping table for pg_search multisearch") do
#       drop_table :pg_search_documents
#     end
#   end
# end


def up
  execute "create index pins on articles using gin(to_tsvector('english', description))"

end

def down
  execute "drop index pins"
end
end