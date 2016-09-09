module ArticleHelpers
  def have_manage_links
    have_link("Edit")
    have_link("Delete")
  end
end

RSpec.configure do |config|
  config.include ArticleHelpers, type: :feature
end
