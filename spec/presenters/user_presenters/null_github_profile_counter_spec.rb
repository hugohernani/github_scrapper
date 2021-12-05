require 'rails_helper'

describe UserPresenters::NullGithubProfileCounter do
  it 'returns a localized message for given counter method' do
    any_counter_method = 'Stars'
    presenter              = UserPresenters::NullGithubProfileCounter.new(any_counter_method)
    localized_null_counter = I18n.t('helpers.github_profile.null_counter', counter_type: any_counter_method)

    expect(presenter.to_s).to eq(localized_null_counter)
  end
end
