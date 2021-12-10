# TODO: FIX-ME Split responsibilies: handle presentation and searching
class UsersContainerPresenter < BasePresenter
  include Enumerable

  def initialize(users)
    @users = users
  end

  def search(search_query:, decorator: UserPresenter)
    @search_query     = search_query
    found_users       = MultipleFieldRansackSearch.new(@users)
                                                  .search(search_query, fields: searchable_fields)
    @users_presenters = decorate(decorator, found_users)
    self
  end

  def each(&block)
    @users_presenters.each(&block)
  end

  def size
    @users_presenters.length
  end

  def search_link
    users_path
  end

  def search_query
    @search_query || ''
  end

  private

  def decorate(decorator, users)
    users.map do |user|
      decorator.new(db_user: user)
    end
  end

  def searchable_fields
    primary_info_fields + github_profile_fields
  end

  def primary_info_fields
    [:name]
  end

  def github_profile_fields
    %i[github_profile_username github_profile_localization github_profile_organization]
  end
end
