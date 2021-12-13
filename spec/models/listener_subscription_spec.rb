require 'rails_helper'

describe ListenerSubscription do
  subject(:subscription){ described_class.new(publisher: publisher, listeners: listeners) }

  let(:publisher) do
    Class.new do
      class << self
        include Wisper::Publisher
      end

    end
  end

  let(:listeners){ [double(), double()] }

  it 'subscribe listener into given publisher' do
    expect(publisher).to receive(:subscribe).exactly(listeners.size).times

    subscription.subscribe
  end
end
