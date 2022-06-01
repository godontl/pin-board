class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_pin, only: [:show, :edit, :update, :destroy]

  #  def index
  #    @comment = Comment.all
  #  end

  #  def new
  #    @comment = Comment.new
  #  end

  def create
    @pin = Pin.find(params[:pin_id])
    @comment = @pin.comments.create(comment_params)
    if @comment.save
      redirect_to pin_path(@pin), notice: "Commento pubblicato"
    else
      render 'new'
    end
  end

#  def show
#    @comment = Comment.find(params[:pin_id])
#  end

  def edit
    @comment = Comment.find(params[:pin_id])
  end

  def update
    @comment = Comment.find(params[:pin_id])
    if @comment.user == current_user
      if @comment.update(comment_params)
        redirect_to @comment, notice: "Il Commento è stato modificato correttamente!"
      else
        render 'edit'
      end
    else
      redirect_to @comment, notice: "Il Commento non può essere modificato perchè non sei l'autore."
    end
  end

  def destroy
    @comment = Comment.find(params[:pin_id])
    if @comment.user == current_user
      @comment.destroy
      redirect_to root_path, notice: "Il Commento è stato cancellato correttamente!"
    else
      redirect_to @comment, notice: "Il Commento non può essere cancellato perchè non sei l'autore."
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:body)
    end
end
