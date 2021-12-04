require 'rails_helper'

describe UserPresenter do
  let(:db_user){ create(:user, :with_github_profile) }

  describe 'some custom view methods' do
    let(:presenter){ described_class.new(db_user: db_user) }

    it 'returns last web scrapping update' do
      scrapping_update_value           = db_user.github_profile.updated_at
      scrapping_update_localized_value = I18n.l(scrapping_update_value)
      scraping_update_message          = I18n.t('user_registration.show.last_seen_at',
                                                last_seen_at: scrapping_update_localized_value)

      expect(presenter.last_github_scrapping_update).to eq(scraping_update_message)
    end
  end

  describe 'interface to access some resources on database user record' do
    it 'respond to some existing methods' do
      user = UserPresenter.new(db_user: db_user)

      expect(user).to respond_to_methods(delegated_methods)
    end

    def delegated_methods
      user_methods + github_methods
    end

    def user_methods
      %i[name url short_url]
    end

    def github_methods
      %w[username followers following stars contributions image_url].map do |github_method|
        "github_#{github_method}".to_sym
      end
    end
  end

  matcher :respond_to_methods do |expected_methods|
    match do |actual_record|
      Array(expected_methods).each do |method|
        expect(actual_record).to respond_to(method)
      end
    end
  end
end
