module CustomMatchers
  module RequestResponse
    extend RSpec::Matchers::DSL

    matcher :have_responded_as do |status, on_view: nil, with_assigns: nil|
      match do |actual_response|
        expect(actual_response).to have_http_status(status)
        expect(actual_response).to render_template(on_view) if on_view

        if with_assigns
          Array(with_assigns).each do |assigned_variable|
            expect(assigns[assigned_variable]).to be_truthy
          end
        end
      end
    end
  end
end
