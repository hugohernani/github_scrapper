require 'sinatra/base'

class FakeGitHub < Sinatra::Base
  get '/*' do
    file_response 200, 'profile.html'
  end

  private

  def file_response(response_code, file_name)
    status response_code
    file_path = Rails.root.join('spec', 'fixtures', 'github_html_content', file_name)
    File.open(file_path).read
  end
end
