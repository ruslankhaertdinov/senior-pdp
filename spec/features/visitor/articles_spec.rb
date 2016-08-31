require "rails_helper"

feature "User articles" do
  scenario "Visitor sees free and premium articles list for given author" do
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

  scenario "Visitor can show only free article" do
    user = create(:user)
    article_1 = create(:article, :free, user: user)
    article_2 = create(:article, :premium, user: user)

    visit user_article_path(user_id: user, id: article_1)

    expect(page).to have_text(article_1.title)
    expect(page).to have_text(article_1.body)

    visit user_article_path(user_id: user, id: article_2)

    expect(page).not_to have_text(article_2.title)
    expect(page).not_to have_text(article_2.body)
  end
end
