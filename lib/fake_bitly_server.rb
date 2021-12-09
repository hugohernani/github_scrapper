require 'sinatra/base'

class FakeBitlyServer < Sinatra::Base
  post '/v4/shorten' do
    bitly_link_response 200, 'bitly_create_link_response.json'
  end

  private

  def bitly_link_response(response_code, file_name)
    content_type :json
    status response_code
    file_path = Rails.root.join('spec', 'fixtures', 'bitly_content', file_name)
    File.read(file_path)
  end
end
