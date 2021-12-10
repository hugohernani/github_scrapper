require 'rails_helper'

describe Github::UserUpdate, **Utils.mocked_server_flags do
  subject(:user_update_service){ described_class.new(new_user_form, user: user) }

  let(:user){ create(:user, :with_github_profile) }

  let(:new_user_form) do
    UserForm.new(
      name: Faker::Name.name_with_middle, url: Faker::Internet.url(host: 'github.com')
    )
  end

  describe 'user record updating' do
    it 'updates primary info based on given user form' do
      expect do
        user_update_service.update
      end.to change(user, :name)
        .from(user.name).to(new_user_form.name)
        .and change(user, :url)
        .from(user.url).to(new_user_form.url)
    end

    context 'using active job' do
      perform_enqueue_jobs

      it 'updates github profile data on related user' do
        github_profile = user.github_profile

        expect do
          user_update_service.update
          github_profile.reload
        end.to change(github_profile, :username)
          .and change(github_profile, :followers)
          .and change(github_profile, :following)
          .and change(github_profile, :stars)
          .and change(github_profile, :contributions)
          .and change(github_profile, :image_url)
          .and change(github_profile, :organization)
          .and change(github_profile, :localization)
      end
    end
  end
end
