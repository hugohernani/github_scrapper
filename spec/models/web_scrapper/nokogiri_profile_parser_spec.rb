require 'rails_helper'

describe WebScrapper::NokogiriProfileParser do
  subject(:parser){ described_class.new }

  let(:raw_html){ File.read(Rails.root.join('spec', 'fixtures', 'github_html_content', 'profile.html')) }

  it 'parses profile html content from github page onto profile object' do
    profile_data = parser.parse(raw_html)

    expected_profile_structure = {
      username: be_a(String),
      followers: be_a(Integer),
      following: be_a(Integer),
      stars: be_a(Integer),
      contributions: be_a(Integer),
      image_url: be_a(String)
    }

    expect(profile_data).to have_attributes(expected_profile_structure)
  end
end
