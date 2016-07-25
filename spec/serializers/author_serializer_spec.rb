require "rails_helper"

describe AuthorSerializer do
  let(:user) { build :user }
  let(:json) { ActiveModel::SerializableResource.new(user, serializer: described_class).to_json }
  let(:user_json) { JSON.parse(json)["user"] }

  it "returns author" do
    expect(user_json).to be_an_author_representation
  end
end
