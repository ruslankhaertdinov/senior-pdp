module FormHelpers
  def have_owner_links
    have_link("Edit")
    have_link("Delete")
  end
end

RSpec.configure do |config|
  config.include FormHelpers, type: :feature
end
