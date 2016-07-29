require "rails_helper"

describe "Locations", type: :request do
  let(:response_body) { JSON.parse(response.body) }

  let(:coords)          { { "latitude" => 37, "longitude" => -122 } }
  let(:expected_result) { { "coords" => coords } }

  before do
    create(:article)

    allow(FetchLocation).to receive_message_chain(:new, :to_h).and_return(coords)
  end

  it "fetches user location by ip address" do
    get "/locations/fetch"

    expect(response_body).to eq(expected_result)
  end
end
