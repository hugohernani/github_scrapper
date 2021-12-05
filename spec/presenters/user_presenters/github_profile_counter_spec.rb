require 'rails_helper'


describe UserPresenters::GithubProfileCounter do
  subject(:presenter){ described_class.new(github_profile: github_profile) }

  shared_examples 'existing messaging counter profile' do |counter_argument|
    let(:github_profile){ build(:github_profile, user: nil) }

    it 'returns counter argument interpolated into a localized message' do
      value             = github_profile.send(counter_argument)
      localized_message = I18n.t('users.show.github_counter_text', amount: value, counter_type: counter_argument)

      expect(presenter.send(counter_argument)).to eq localized_message
    end
  end

  shared_examples 'non existing messaging counter profile' do |counter_argument|
    let(:github_profile){ build(:github_profile, "#{counter_argument}": nil) }

    it 'delegates message rendering to null object' do
      expect(UserPresenters::NullGithubProfileCounter).to receive(:new).with(counter_argument)

      presenter.send(counter_argument)
    end
  end

  %i[followers following stars contributions].each do |counter_argument|
    it_behaves_like 'existing messaging counter profile', counter_argument
  end

  %i[organization localization].each do |counter_argument|
    it_behaves_like 'non existing messaging counter profile', counter_argument
  end
end
