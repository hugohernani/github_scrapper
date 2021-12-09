module CustomMatchers
  module UserListing
    extend RSpec::Matchers::DSL

    def user_table_row(page, user)
      page.find(:css, "table.users-listing tbody tr##{user.id}")
    end

    matcher :have_action_buttons_on_user_row do |given_user|
      match do |page|
        have_details_button(actions_column(page), given_user) &&
          have_edit_button(actions_column(page), given_user) &&
          have_delete_button(actions_column(page), given_user)
      end

      define_method :actions_column do |page|
        table_row = user_table_row(page, given_user)
        table_row.find(:css, 'td.actions')
      end

      def have_details_button(column, user)
        expect(column).to have_link(I18n.t('helpers.buttons.show'), href: "/users/#{user.id}")
      end

      def have_edit_button(column, user)
        expect(column).to have_link(I18n.t('helpers.buttons.edit'), href: "/users/#{user.id}/edit")
      end

      def have_delete_button(column, user)
        expect(column).to have_link(I18n.t('helpers.buttons.delete'), href: "/users/#{user.id}")
      end

      failure_message do |actual|
        'expected that all action buttons were available'
      end
    end

    matcher :have_table_row_with_primary_info do |given_user|
      match do |page|
        have_row(table_row(page)) &&
          have_name(table_row(page), given_user.name)
      end

      define_method :table_row do |page|
        user_table_row(page, given_user)
      end

      def have_row(table_row)
        expect(table_row).not_to be_nil
      end

      def have_name(table_row, name)
        expect(table_row).to have_text(name)
      end
    end


  end
end


module CustomMatchers
  module RequestResponse
    extend RSpec::Matchers::DSL

    matcher :have_responded_as do |status, on_view: nil, redirect_path: nil, with_assigns: nil|
      match do |actual_response|
        match_status?(actual_response, status) &&
          match_template?(actual_response, on_view) &&
          match_redirect?(actual_response, redirect_path) &&
          match_assigns?(with_assigns)
      end

      def match_status?(response, expected_status)
        expect(response).to have_http_status(expected_status)
      end

      def match_template?(response, expected_template)
        return true unless optional_expectation?(expected_template)

        expect(response).to(render_template(expected_template))
      end

      def match_redirect?(response, expected_redirect_path)
        return true unless optional_expectation?(expected_redirect_path)

        expect(response).to(redirect_to(expected_redirect_path))
      end

      def match_assigns?(assigned_variables)
        return true unless optional_expectation?(assigned_variables)

        Array(assigned_variables).compact.all? do |assigned_variable|
          expect(assigns[assigned_variable]).to be_truthy
        end
      end

      def optional_expectation?(expected_value)
        !!expected_value
      end
    end
  end
end
