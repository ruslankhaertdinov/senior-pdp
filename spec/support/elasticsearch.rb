# RSpec.configure do |config|
#   config.around :each, elasticsearch: true do |example|
#     [Article].each do |model|
#       model.__elasticsearch__.create_index!(force: true)
#       model.__elasticsearch__.refresh_index!
#     end
#     example.run
#     Article.__elasticsearch__.client.indices.delete index: Article.index_name
#   end
# end
