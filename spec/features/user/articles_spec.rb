require "rails_helper"

feature "User sees articles" do
  include_context "current user signed in"

  scenario "User sees articles for given author" do
    user_1 = create(:user)
    user_2 = create(:user)

    article_1 = create(:article, :free, user: user_1)
    article_2 = create(:article, :premium, user: user_1)
    article_3 = create(:article, :premium, user: user_2)

    visit user_articles_path(user_id: user_1)

    expect(page).to have_text(article_1.title)
    expect(page).to have_text(article_2.title)
    expect(page).to have_text("Get premium access")

    expect(page).not_to have_text(article_3.title)
  end

  scenario "Visitor can see free article" do
    user_1 = create(:user)
    article = create(:article, :free, user: user_1)

    visit user_article_path(user_id: user_1, id: article)

    expect(page).to have_text(article.title)
    expect(page).to have_text(article.body)
    expect(page).not_to have_text("Get premium access")
  end

  scenario "User can't see premium article content" do
    user_1 = create(:user)
    article = create(:article, :premium, user: user_1)

    visit user_article_path(user_id: user_1, id: article)

    expect(page).to have_text(article.title)
    expect(page).not_to have_text(article.body)
    expect(page).to have_link("Get premium access")
  end

  scenario "User can see paid article content" do
    user_1 = create(:user)
    article = create(:article, :premium, user: user_1)
    allow(current_user).to receive(:subscribed?).and_return(true)

    visit user_article_path(user_id: user_1, id: article)

    expect(page).to have_text(article.title)
    expect(page).to have_text(article.body)
    expect(page).not_to have_link("Get premium access")
  end
end
