require "rails_helper"

feature "Account Articles" do
  include_context "current user signed in"

  scenario "Author shows own articles" do
    article_1 = create(:article, title: "First article", user: current_user)
    article_2 = create(:article, title: "Second article")

    visit account_articles_path

    expect(page).to have_text(article_1.title)
    expect(page).to have_manager_links
    expect(page).not_to have_text(article_2.title)
  end

  scenario "Author shows own article" do
    article = create(:article, user: current_user)

    visit account_article_path(article)

    expect(page).to have_text(article.title)
    expect(page).to have_text(article.body)
    expect(page).to have_manager_links
  end

  scenario "Author creates article with valid params" do
    visit new_account_article_path

    fill_form :article, attributes_for(:article).slice(:title, :body)
    click_on submit(:article)

    expect(page).to have_text("Article was successfully created.")
  end

  scenario "Author creates article with invalid params" do
    visit new_account_article_path

    click_on submit(:article)

    expect(page).to have_text("Titlecan't be blank")
    expect(page).to have_text("Bodycan't be blank")
  end

  scenario "Author updates article" do
    article = create(:article, title: "First article", body: "Coll content", user: current_user)

    visit account_article_path(article)

    expect(page).to have_text("First article")
    expect(page).to have_text("Coll content")
    expect(page).to have_text("Available for free: true")

    click_on "Edit"
    refill_form_and_submit

    expect(page).to have_text("Article was successfully updated.")
    expect(page).to have_text("Updated title")
    expect(page).to have_text("Updated body")
    expect(page).to have_text("Available for free: false")
  end

  scenario "Author deletes own article" do
    article = create(:article, title: "First article", user: current_user)

    visit account_article_path(article)
    click_on "Delete"

    expect(page).to have_text("Article was successfully destroyed.")
  end

  def refill_form_and_submit
    fill_in "Title", with: "Updated title"
    fill_in "Body", with: "Updated body"
    uncheck "article_free"
    click_on submit(:article, :update)
  end
end
