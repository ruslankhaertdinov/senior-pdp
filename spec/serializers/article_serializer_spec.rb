require "rails_helper"

describe ArticleSerializer do
  let(:article) { build :article }
  let(:json) { ActiveModelSerializers::SerializableResource.new(article).to_json }
  let(:user_json) { JSON.parse(json)["article"] }

  it "returns article" do
    expect(user_json).to be_an_article_representation
  end
end
