module Users
  class GithubScrapperController < ApplicationController
    def create
      user = User.find(params[:id])

      WebScrapper::GithubProfileLoader.new(user_id: user.id)
                                      .load_onto_user(url: user.url)

      redirect_to user_path(user), notice: t('.success')
    end
  end
end
