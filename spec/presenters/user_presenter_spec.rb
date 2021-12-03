require 'rails_helper'

describe UserPresenter do
  let(:db_user){ create(:user, :with_github_profile) }

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
