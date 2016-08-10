require "rails_helper"

describe UsersByArticle do
  let(:query)   { "read" }
  let(:user_1)  { create :user  }
  let(:user_2)  { create :user  }
  let(:user_3)  { create :user  }
  let(:service) { described_class.new(query) }

  before do
    create :article, user: user_1, title: "I like read"
    create :article, user: user_2, title: "I am reading book"
    create :article, user: user_3, title: "I like meat"

    Article.import(force: true, refresh: true)
  end

  it "returns users with matched articles body" do
    expect(service.all).to match_array([user_1, user_2])
  end
end
