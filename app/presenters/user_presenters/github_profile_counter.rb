module UserPresenters
  class GithubProfileCounter < BasePresenter
    def initialize(github_profile:)
      @github_profile = github_profile
    end

    %w[organization localization].each do |counter_method|
      define_method counter_method do
        counter_message_for(counter_method)
      end
    end

    %w[followers following stars contributions].each do |counter_method|
      define_method "#{counter_method}_message" do
        counter_message_for(counter_method)
      end
    end

    private

    attr_reader :github_profile

    def counter_message_for(counter_method)
      counter = github_profile.send(counter_method)

      return UserPresenters::NullGithubProfileCounter.new(counter_method) unless counter

      h.t('users.show.github_counter_text', amount: counter, counter_type: counter_method.capitalize)
    end
  end
end
