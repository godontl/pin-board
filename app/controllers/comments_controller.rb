class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_pin

  #  def index
  #    @comment = Comment.all
  #  end

  # def new
  #   @comment = Comment.build
  # end

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

  def destroy
    @comment = Comment.find(params[:id])
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
end
