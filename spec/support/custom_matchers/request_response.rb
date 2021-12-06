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
