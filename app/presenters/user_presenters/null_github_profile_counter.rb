module UserPresenters
  class NullGithubProfileCounter < BasePresenter
    def initialize(counter_method)
      @counter_method = counter_method
    end

    def to_s
      h.t('helpers.github_profile.null_counter', counter_type: @counter_method.capitalize)
    end
  end
end
