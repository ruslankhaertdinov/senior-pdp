RSpec::Matchers.define :be_an_author_representation do
  match do |json|
    response_attributes = %w(
      lat
      lng
      info
    )

    expect(json).to be
    expect(json.keys).to match_array(response_attributes)
  end
end
