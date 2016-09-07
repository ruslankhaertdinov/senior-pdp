require "rails_helper"

feature "User subscribes to premium articles" do
  include_context "current user signed in"

  let(:credit_card) { "4242424242424242" }
  let(:expiration) { I18n.l(1.year.from_now, format: :expiration) }

  scenario "User subscribes to author articles", :js do
    pending
    user = create(:user)
    article = create(:article, :premium, user: user)

    visit user_article_path(user_id: user, id: article)
    expect(page).to have_link("Get premium access")
    expect(page).not_to have_text(article.body)

    click_on("Get premium access")
    expect(page).to have_css("section.subscription")

    # test broken here: there are no stripe buttons
    expect(page).to have_text("Week: $7")
    # save_and_open_page
    # page.execute_script("$('button[type=submit]')[0].click()")
    # save_and_open_page
    expect(page).to have_text("Subscription for 1 week")

    fill_in "email", with: user.email
    fill_in "credit_card", with: credit_card
    fill_in "expiration", with: expiration
    fill_in "cvc", with: 123
    click_on("#button")

    expect(page).to have_text("You subscribed successfully!")
    expect(page).not_to have_css("section.subscription")

    visit user_article_path(user_id: user, id: article)
    expect(page).not_to have_link("Get premium access")
    expect(page).to have_text(article.body)

    visit user_article_path(user_id: user_2, id: article)
    expect(page).to have_link("Get premium access")
    expect(page).not_to have_text(article_2.body)
  end
end
