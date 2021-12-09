module Utils
  def self.mocked_server_flags
    {
      github_fake_response: true,
      bitly_fake_response: true
    }
  end

  def self.fixture_file(path)
    file_path = Rails.root.join('spec', 'fixtures', path)
    File.read(file_path)
  end
end
