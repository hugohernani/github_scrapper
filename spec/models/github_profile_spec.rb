require 'rails_helper'

RSpec.describe GithubProfile, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end
end
