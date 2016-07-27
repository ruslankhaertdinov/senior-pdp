require "rails_helper"

describe UsersByArticleContent do
  let(:query) { "read" }
  let(:service) { described_class.new(query) }
  let(:user_1) { create :user  }
  let(:user_2) { create :user  }
  let(:user_3) { create :user  }

  before do
    create :article, user: user_1, body: "I like bread"
    create :article, user: user_2, body: "I am reading book"
    create :article, user: user_3, body: "I like fresh breath"
  end

  it "returns users with matched articles body" do
    expect(service.all).to match_array([user_1, user_2])
  end
end
