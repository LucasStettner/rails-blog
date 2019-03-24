class PostsController < ApplicationController
  http_basic_authenticate_with name: "lucas", password: "1234", except: [:index, :show]

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    # render plain: params[:post].inspect

    # New variable with the post params
    @post = Post.new(post_params)

    # This code will actually save the params submitted to the table
   if(@post.save)
     # This will redirect to the show view if passed by the validation
     redirect_to @post
   else
     # If validation fails it will re-render the code
     render 'new'
   end

  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if(@post.update(post_params))
      # This will redirect to the show view if passed by the validation
      redirect_to @post
    else
      # If validation fails it will re-render the code
      render 'edit'
    end

  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to posts_path
  end

  # Private function that restricts params to only having a title and body
  private def post_params
    params.require(:post).permit(:title, :body)
  end

end
