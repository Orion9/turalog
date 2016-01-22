class Admin::SessionsController < Admin::ApplicationController
  layout 'admin/login'

  def new
  end

  def create
    user = User.authentication(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to admin_posts_path, :notice => 'Welcome abroad, Captain!'
    else
      flash.now.alert = 'Do not play dirty!'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to admin_login_path, notice: 'Good bye...'
  end
end
