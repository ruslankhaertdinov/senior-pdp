require "rails_helper"

describe "Articles", type: :request do
  let(:response_body) { JSON.parse(response.body) }

  before do
    create_list(:article, 2)
  end

  it "returns all articles json" do
    get "/articles.json"

    expect(response_body["articles"].size).to eq(2)
    expect(response_body["articles"].first).to be_an_article_representation
  end
end
