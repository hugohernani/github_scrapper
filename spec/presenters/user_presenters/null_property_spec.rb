require 'rails_helper'

describe UserPresenters::NullProperty do
  it 'returns a localized message for given property method' do
    any_property_method     = 'Stars'
    presenter               = UserPresenters::NullProperty.new(any_property_method)
    localized_null_property = I18n.t('helpers.null_property', property_type: any_property_method)

    expect(presenter.to_s).to eq(localized_null_property)
  end
end
