require 'rails_helper'

describe UserForm, type: :model do
  describe 'presence validations' do
    %i[name url].each do |attr|
      it { is_expected.to validate_presence_of(attr) }
    end
  end
end
