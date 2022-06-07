class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_pin
  before_action :find_comment, except: [:create]

  def index
      @comment = Comment.all
    end

    def new
      user = session[:user_id]
      @comment = Comment.new(post_id: params[:post_id])
      @post = Post.find(params[:post_id])
    end

  def create
    @comment = Comment.create(comment_params)
    @comment.pin = @pin
    @comment.user = current_user
    if @comment.save!
      redirect_to pin_path(@pin), notice: "Il commento è stato creato."
    else
      redirect_to pin_path(@pin), notice: "Il commento non è stato creato. Errore: #{@comment.errors[]}"
    end
  end

  def edit
  end

  def update
    if @comment.user == current_user
      @comment.body = params["comment"]["body"]
      if @comment.save!
        redirect_to '/pins', notice: "Il commento è stato modificato correttamente!"
      else
        render 'edit'
      end
    else
      redirect_to '/pins', notice: "Il commento non può essere modificato perchè non sei l'autore."
    end
  end

  def destroy
    if @comment.user == current_user || @pin.user == current_user
      @comment.destroy
      redirect_to pin_path(@pin), notice: "Il Commento è stato cancellato correttamente!"
    else
      redirect_to pin_path(@pin), notice: "Il Commento non può essere cancellato perchè non sei l'autore."
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:body, :pin_id)
    end
    def find_pin
      @pin = Pin.find(params[:pin_id])
    end
    def find_comment
      @comment = Comment.find(params[:id])
    end
end
