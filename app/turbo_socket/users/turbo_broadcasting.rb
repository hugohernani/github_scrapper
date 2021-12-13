module Users
  class TurboBroadcasting
    def user_updated(data)
      user = UserPresenter.new(db_user: data.fetch(:user))
      broadcast_onto_user_input(user)
      broadcast_flash_message(user, I18n.t('users.update.success'))
    end

    def user_profile_updated(data)
      user = UserPresenter.new(db_user: data.fetch(:user))
      broadcast_onto_users_listing(user)
      broadcast_onto_user_view(user)
      broadcast_flash_message(user, I18n.t('users.github_scrapper.success'))
    end

    private

    def broadcast_onto_users_listing(user)
      Turbo::StreamsChannel.broadcast_prepend_to(
        'user_listing', target: 'user_listing', partial: 'users/user', locals: { user: user }
      )
    end

    def broadcast_onto_user_input(user)
      Turbo::StreamsChannel.broadcast_replace_to(
        user, target: 'user_input', partial: 'users/profile/user_input', locals: { user: user }
      )
    end

    def broadcast_onto_user_view(user)
      Turbo::StreamsChannel.broadcast_replace_to(
        user, target: 'user_details', partial: 'users/info', assigns: { user: user }
      )
    end

    def broadcast_flash_message(user, message)
      flash = ActionDispatch::Flash::FlashHash.new
      flash.now[:notice] = message
      Turbo::StreamsChannel.broadcast_prepend_to(
        user, target: 'flash-messages', partial: 'layouts/flash_messages', locals: { flash: flash }
      )
    end
  end
end
