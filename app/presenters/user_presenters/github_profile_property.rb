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
      UserPresenters::Property.new(github_profile, counter_property).message(locale_path: 'helpers.property_counter')
    end

    def property_message_for(generic_property)
      UserPresenters::Property.new(github_profile, generic_property).message
    end
  end
end
