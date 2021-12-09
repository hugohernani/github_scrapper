require 'rails_helper'

describe UserPresenters::NullGithubProfileProperty do
  it 'returns a localized message for given property method' do
    any_property_method = 'Stars'
    presenter              = UserPresenters::NullGithubProfileProperty.new(any_property_method)
    localized_null_property = I18n.t('helpers.github_profile.null_property', property_type: any_property_method)

    expect(presenter.to_s).to eq(localized_null_property)
  end
end
