require "rails_helper"

feature "Update Account" do
  include_context "current user signed in"
  include_context "geocoder stubbed"

  let(:attributes) do
    {
      full_name: "New Name",
      country:   "Russia",
      city:      "Kazan",
      address:   "Pushkina, 46"
    }
  end

  background do
    create(:article)

    visit edit_user_registration_path(current_user)
  end

  scenario "User updates account with valid data" do
    fill_form(:user, attributes)
    click_on "Update"

    expect(page).to have_text("Your account has been updated successfully.")
    expect(page).to have_content(attributes[:full_name])
  end
end
