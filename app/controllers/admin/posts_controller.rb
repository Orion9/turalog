class Admin::PostsController < Admin::ApplicationController
  before_filter :is_user_logged

  def new
    @page_title = 'Add New Post'
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = 'Post created!'
      redirect_to admin_posts_path
    else
      render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      flash[:notice] = 'Post updated!'
      redirect_to admin_posts_path
    else
      render 'new'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    flash[:notice] = 'Post destroyed ruthlessly!'
    redirect_to admin_posts_path
  end

  def index
    if params[:search]
      @posts = Post.search(params[:search]).all.order('created_at DESC')
                   .paginate(:per_page => 10, :page => params[:page])
    else
      @posts = Post.all.order('created_at DESC').paginate(:per_page => 10, :page => params[:page])
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :category_id, :user_id, :tags, :body)
  end
end
