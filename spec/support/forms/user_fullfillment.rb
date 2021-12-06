module Forms
  class UserFullfillment
    def initialize(capybara_node)
      @capybara_node = capybara_node
    end

    def fill_form
      capybara_node.fill_in 'user_form_name', with: Faker::Name.name_with_middle
      capybara_node.fill_in 'user_form_url', with: Faker::Internet.url(host: 'github.com')
    end

    private

    attr_reader :capybara_node
  end
end
