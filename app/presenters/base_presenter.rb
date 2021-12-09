class BasePresenter
  include BasePresentable

  protected

  def h
    ApplicationController.helpers
  end
end
