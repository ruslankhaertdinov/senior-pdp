RSpec::Matchers.define :be_an_article_representation do
  match do |json|
    response_attributes = %w(id title)

    expect(json).to be
    expect(json.keys).to match_array(response_attributes)
  end
end
