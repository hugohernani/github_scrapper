module UserPresenters
  class Property < BasePresenter
    def initialize(holder, property)
      @holder   = holder
      @property = property
    end

    def message(locale_path: 'helpers.property')
      property_value = holder&.send(property)

      return UserPresenters::NullProperty.new(property) unless property_value

      h.t(locale_path, value: property_value, type: property.capitalize)
    end

    private

    attr_reader :holder, :property
  end
end
