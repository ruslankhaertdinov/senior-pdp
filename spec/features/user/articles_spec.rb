require "rails_helper"

feature "User sees articles" do
  include_context "current user signed in"

  context "without subscription" do
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

    scenario "User can see free article" do
      article = create(:article, :free)

      visit user_article_path(user_id: article.user, id: article)

      expect(page).to have_text(article.title)
      expect(page).to have_text(article.body)
      expect(page).not_to have_link("Get premium access")
    end

    scenario "User can't see premium article content" do
      article = create(:article, :premium)

      visit user_article_path(user_id: article.user, id: article)

      expect(page).to have_text(article.title)
      expect(page).not_to have_text(article.body)

      click_on("Get premium access")

      expect(page).to have_css("section.subscription")
    end
  end

  context "with subscription" do
    let(:article) { create(:article, :premium) }

    before do
      create(:subscription, user: current_user, author: article.user)
    end

    scenario "User can see paid articles" do
      visit user_article_path(user_id: article.user, id: article)

      expect(page).to have_text(article.title)
      expect(page).to have_text(article.body)
      expect(page).not_to have_link("Get premium access")

      click_on("More author articles")

      expect(page).not_to have_link("Get premium access")
    end
  end
end
