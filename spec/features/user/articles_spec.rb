require "rails_helper"

feature "User articles" do
  scenario "User sees articles for given user" do
    user_1 = create(:user)
    user_2 = create(:user)

    article_1 = create(:article, user: user_1)
    article_2 = create(:article, user: user_2)

    visit user_articles_path(user_id: user_1)

    expect(page).to have_text(article_1.title)
    expect(page).to have_text(article_1.body[300]) # truncated content
    expect(page).to have_text("Get premium access")

    expect(page).not_to have_text(article_2.title)
  end

  scenario "User can show only free or paid article" do
    user = create(:user)
    article = create(:article, user: user)

    visit user_article_path(user_id: user, id: article)

    expect(page).to have_text(article.title)
    expect(page).to have_text(article.body)
  end
end
