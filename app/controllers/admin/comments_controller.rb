class Admin::CommentsController < Admin::ApplicationController
  before_filter :is_user_logged

  def destroy
  end
end
