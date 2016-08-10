require "rails_helper"
require "rake"

describe UsersByArticle do
  let(:query)   { "read" }
  let(:user_1)  { create :user  }
  let(:user_2)  { create :user  }
  let(:user_3)  { create :user  }
  let(:service) { described_class.new(query) }

  before do
    create :article, user: user_1, title: "I like bread"
    create :article, user: user_2, title: "I am reading book"
    create :article, user: user_3, title: "I like fresh breath"

    Article.import(force: true, refresh: true)
    sleep 2 # to allow Elasticsearch test cluster to index the objects we created
  end

  it "returns users with matched articles title" do
    expect(service.all).to match_array([user_1, user_2])
  end
end
