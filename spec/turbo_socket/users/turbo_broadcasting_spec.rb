require 'rails_helper'

describe Users::TurboBroadcasting do
  subject(:turbo_listener){ described_class.new }

  let!(:user){ create(:user) }

  shared_examples 'broadcastable' do |broadcast_method|
    it "receives incoming user on #{broadcast_method} and delegates broadcast to Turbo" do
      expect do
        turbo_listener.send(broadcast_method, user: user)
      end.to have_broadcasted_to(user.to_gid_param).from_channel(Turbo::StreamsChannel)
    end
  end

  it_behaves_like 'broadcastable', :user_updated
  it_behaves_like 'broadcastable', :user_profile_updated

  it 'delegates broadcast to Turbo on user_listing stream' do
    expect do
      turbo_listener.user_profile_updated(user: user)
    end.to have_broadcasted_to('user_listing').from_channel(Turbo::StreamsChannel)
  end
end
