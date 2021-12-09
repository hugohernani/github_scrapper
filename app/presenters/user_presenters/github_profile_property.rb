module UserPresenters
  class GithubProfileProperty < BasePresenter
    def initialize(github_profile:)
      @github_profile = github_profile
    end

    %w[organization localization].each do |generic_property|
      define_method generic_property do
        property_message_for(generic_property)
      end
    end

    %w[followers following stars contributions].each do |counter_property|
      define_method "#{counter_property}_message" do
        counter_message_for(counter_property)
      end
    end

    private

    attr_reader :github_profile

    def counter_message_for(counter_property)
      message_for(counter_property, 'users.show.github_counter_text')
    end

    def property_message_for(generic_property)
      message_for(generic_property, 'users.show.github_property_text')
    end

    def message_for(github_propery_name, message_path)
      profile_value = github_profile.send(github_propery_name)

      return UserPresenters::NullGithubProfileProperty.new(github_propery_name) unless profile_value

      h.t(message_path, value: profile_value, type: github_propery_name.capitalize)
    end
  end
end
