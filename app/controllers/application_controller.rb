class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  PERMISSIBLE_ATTRIBUTES = %i(name avatar avatar_cache)

  def after_sign_in_path_for(resource)
    if current_user.sign_in_count == 1
      unless current_user.organizer_flg
        new_artist_path
      else
        new_organizer_path
      end
    else
      root_path
    end
  end
end
