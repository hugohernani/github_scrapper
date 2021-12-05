module ButtonsHelper
  def primary_button(text, url: '#', css_classes: [], **opts)
    link_to(text, url, class: primary_button_css_classes(css_classes), **opts)
  end

  def secondary_button(text, url: '#', css_classes: [], **opts)
    link_to(text, url, class: secondary_button_css_classes(css_classes), **opts)
  end

  def danger_button(text, url: '#', css_classes: [], alert_message: nil, **opts)
    link_to(text, url, class: danger_button_css_classes(css_classes), data: {
              confirm: alert_message
            }, **opts)
  end

  private

  def primary_button_css_classes(incoming_css_classes)
    %w[btn btn-primary btn-block]
      .concat(incoming_css_classes)
      .join(' ')
  end

  def secondary_button_css_classes(incoming_css_classes)
    %w[btn btn-info btn-block]
      .concat(incoming_css_classes)
      .join(' ')
  end

  def danger_button_css_classes(incoming_css_classes)
    %w[btn btn-danger btn-block]
      .concat(incoming_css_classes)
      .join(' ')
  end
end
