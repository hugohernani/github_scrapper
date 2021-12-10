module UserPresenters
  class NullProperty < BasePresenter
    def initialize(property_method)
      @property_method = property_method
    end

    def to_s
      h.t('helpers.null_property', property_type: @property_method.capitalize)
    end
  end
end
