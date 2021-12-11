require 'rails_helper'

describe UserForm do
  subject(:form){ described_class.new(name: name, url: url) }

  context 'when valid' do
    let(:name){ Faker::Name.name_with_middle }
    let(:url){ Faker::Internet.url }

    it 'returns true' do
      expect(form.valid?).to eq(true)
    end
  end

  context 'when invalid', 'missing name' do
    let(:name){ nil }
    let(:url){ Faker::Internet.url }

    it 'returns false' do
      expect(form.valid?).to eq(false)
    end

    it 'returns name error' do
      form.valid?

      expect(form.errors.full_messages).to include("Name can't be blank")
    end
  end

  context 'when invalid', 'wrong url format' do
    let(:name){ Faker::Name.name_with_middle }
    let(:url){ 'google,com' }

    it 'returns false' do
      expect(form.valid?).to eq(false)
    end

    it 'returns name error' do
      form.valid?

      expect(form.errors.full_messages).to include('Url is invalid')
    end
  end
end
