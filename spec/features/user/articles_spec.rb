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

  scenario "Author shows own article" do
    article = create(:article, title: "First article", user: current_user)

    visit author_article_path(article)

    expect(page).to have_text(article.title)
    expect(page).to have_text(article.body)
    expect(page).to have_link("Edit")
    expect(page).to have_link("Delete")
  end

  scenario "Author creates article with valid params" do
    visit new_author_article_path

    fill_in "Title", with: "Awesome title"
    fill_in "Body", with: "Great content"
    find('input[name="commit"]').click

    expect(page).to have_text("Article created successful!")
  end

  scenario "Author creates article with invalid params" do
    visit new_author_article_path

    find('input[name="commit"]').click

    expect(page).to have_text("Titlecan't be blank")
    expect(page).to have_text("Bodycan't be blank")
  end

  scenario "Author updates article" do
    article = create(:article, title: "First article", user: current_user)

    visit edit_author_article_path(article)

    fill_in "Title", with: "Updated title"
    find('input[name="commit"]').click

    expect(page).to have_text("Updated title")
    expect(page).to have_text("Article updated successful!")
  end

  scenario "Author deletes own article" do
    article = create(:article, title: "First article", user: current_user)

    visit author_article_path(article)
    click_on("Delete")

    expect(page).to have_text("Article deleted successful!")
  end
end
