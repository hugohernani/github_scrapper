require 'rails_helper'

describe UsersContainerPresenter do
  subject(:presenter){ described_class.new(users) }

  let(:users){ create_list(:user, 2, :with_github_profile) }

  let(:mocked_ransack_searcher){ instance_double('MultipleFieldRansackSearch', search: users) }

  before do
    allow(MultipleFieldRansackSearch).to receive(:new).with(users).and_return(mocked_ransack_searcher)
  end

  it 'searches users by delegating to given collaborator' do
    expect(MultipleFieldRansackSearch).to receive(:new).with(users).and_return(mocked_ransack_searcher)

    presenter.search(search_query: 'any')
  end

  it 'allows for passing a custom decorator' do
    custom_user_decorator = class_double('UserPresenter', new: nil)

    presenter.search(search_query: 'any', decorator: custom_user_decorator)

    expect(custom_user_decorator).to have_received(:new).with(db_user: be_a(User)).twice
  end
end
