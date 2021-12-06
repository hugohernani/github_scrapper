require 'rails_helper'

describe MultipleFieldRansackSearch do
  subject(:query_object){ described_class.new(ransack_relation) }

  let(:ransack_relation){ User.all }

  context 'with user primary info' do
    let!(:user1){ create(:user, name: 'Jack', url: 'http://github.com/sparrow') }
    let!(:user2){ create(:user, name: 'Any other name', url: 'http://github.com/jack') }
    let!(:user3){ create(:user, name: 'Whatever', url: 'http://github.com/whatever') }

    let(:query){ 'jack' }

    it 'finds users when matching either name or url' do
      result = query_object.search(query, fields: %i[name url]).result

      expect(result).to include(user1, user2)
    end

    it 'does not return non matching user using either name or url' do
      result = query_object.search(query, fields: %i[name url]).result

      expect(result).not_to include(user3)
    end
  end

  context 'with github profile info' do
    let!(:profile1){ create(:github_profile, username: 'fretadao') }
    let!(:profile2){ create(:github_profile, localization: 'Fretadao city') }
    let!(:profile3){ create(:github_profile, organization: 'Fretadao') }
    let!(:profile4){ create(:github_profile, organization: 'whatever') }

    let(:query){ 'fretadao' }

    it 'finds users when matching any one of github profile attributes' do
      result = query_object.search(query,
                                   fields: %i[github_profile_username github_profile_localization
                                              github_profile_organization]).result

      found_users = [profile1, profile2, profile3].map(&:user)

      expect(result).to include(*found_users)
    end

    it 'does not return non matching user if it does not match any one of github profile attributes' do
      result = query_object.search(query,
                                   fields: %i[github_profile_username github_profile_localization
                                              github_profile_organization]).result

      expect(result).not_to include(profile4.user)
    end
  end
end
