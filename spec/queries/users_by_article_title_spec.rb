require "rails_helper"

describe UsersByArticleTitle do
  let(:query) { "read" }
  let(:service) { described_class.new(query) }
  let(:user_1) { create :user  }
  let(:user_2) { create :user  }
  let(:user_3) { create :user  }

  before do
    create :article, user: user_1, title: "I like bread"
    create :article, user: user_2, title: "I am reading book"
    create :article, user: user_3, title: "I like fresh breath"
  end

  it "returns users with matched articles body" do
    expect(service.all).to match_array([user_1, user_2])
  end
end
