require "rails_helper"

feature "Articles" do
  include_context "current user signed in"

  scenario "Author shows own articles" do
    article_1 = create(:article, title: "First article", user: current_user)
    article_2 = create(:article, title: "Second article")

    visit author_articles_path

    expect(page).to have_text(article_1.title)
    expect(page).not_to have_text(article_2.title)
    expect(page).to have_link("Edit")
    expect(page).to have_link("Delete")
  end
end
