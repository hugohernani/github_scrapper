module ButtonsHelper
  def primary_button(text, url: '#', css_classes: [], **opts)
    link_to(text, url, class: button_css_classes('btn-primary', css_classes), **opts)
  end

  def submit_button(text, css_classes: [], **opts)
    submit_tag(text, class: button_css_classes('btn-primary', css_classes), **opts)
  end

  def back_button(text, url: :back, css_classes: [], **opts)
    link_to(text, url, class: button_css_classes('btn-light', css_classes), **opts)
  end

  def secondary_button(text, url: '#', css_classes: [], **opts)
    link_to(text, url, class: button_css_classes('btn-info', css_classes), **opts)
  end

  def danger_button(text, url: '#', css_classes: [], alert_message: nil, **opts)
    link_to(text, url, class: button_css_classes('btn-danger', css_classes), method: :delete, data: {
              confirm: alert_message
            }, **opts)
  end

  private

  def button_css_classes(target_bootstrap_class, custom_css_classes)
    [target_bootstrap_class, 'btn-block', 'btn',]
      .concat(custom_css_classes)
      .join(' ')
  end
end
