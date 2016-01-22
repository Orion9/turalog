class Admin::ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout 'admin/application'

  helper_method :current_user
  before_filter session_sweep: '20 minutes'

  private
    def current_user
      @current_user ||=User.find(session[:user_id]) if session[:user_id]
    end

    def is_user_logged
      unless current_user
        redirect_to admin_login_path
      end
    end

    def session_sweep(time = 1.hour)
        if time.is_a?(String)
          time = time.split.inject { |count, unit| count.to_i.send(unit) }
        end

        delete_all "updated_at < '#{time.ago.to_s(:db)}' OR
                    created_at < '#{2.days.ago.to_s(:db)}'"
    end
end
