class ApplicationController < ActionController::Base
  before_action :config_devise_params, if: :devise_controller?

  layout :layout_by_resource

  protected

  def config_devise_params
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: %i[
        first_name
        last_name
        username
        email
        password
        password_confirmation
      ]
    )

    devise_parameter_sanitizer.permit :sign_in, keys: %i[login password]
  end

  private

  def member_controller?
    return false if controller_path == 'home'

    true
  end

  def layout_by_resource
    if devise_controller?
      'session'
    elsif member_controller?
      'member'
    else
      'application'
    end
  end
end
