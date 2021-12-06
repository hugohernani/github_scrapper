require 'rails_helper'

describe WebScrapper::GithubProfileLoader do
  subject(:loader){ described_class.new(user_id: user.id, web_scrapper: fake_web_scrapper) }

  let!(:user){ create(:user, :with_github_profile) }
  let!(:new_github_profile){ build(:github_profile, user_id: user.id) }
  let(:fake_web_scrapper){ instance_double('WebScrapper::GithubProfile', load_data: new_github_profile) }
  let(:fake_url){ Faker::Internet.url(host: 'github.com') }

  it 'updates github_profile for given user' do
    loader.load_onto_user(url: fake_url)

    expect(user.github_profile.reload).to match_profile(new_github_profile)
  end

  matcher :match_profile do |expect_github_profile|
    match do |actual_github_profile|
      except_attributes = %i[id created_at updated_at]

      current_github_attributes  = actual_github_profile.as_json(except: except_attributes)
      expected_github_attributes = expect_github_profile.as_json(except: except_attributes)

      expect(current_github_attributes).to eq(expected_github_attributes)
    end
  end
end
