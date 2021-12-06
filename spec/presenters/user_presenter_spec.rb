require 'rails_helper'

describe UserPresenter do
  let(:db_user){ create(:user, :with_github_profile) }

  describe 'some custom view methods' do
    let(:presenter){ described_class.new(db_user: db_user) }

    it 'returns last web scrapping update' do
      scrapping_update_value           = db_user.github_profile.updated_at
      scrapping_update_localized_value = I18n.l(scrapping_update_value)
      scraping_update_message          = I18n.t('users.show.last_syncronized_at',
                                                last_update: scrapping_update_localized_value)

      expect(presenter.last_github_scrapping_update).to eq(scraping_update_message)
    end
  end
end
