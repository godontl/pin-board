class PinsController < ApplicationController
 before_action :authenticate_user!, except: [:index, :show]
 before_action :find_pin, only: [:show, :edit, :update, :destroy, :upvote, :downvote]

  def index
    @pins = Pin.all.order("created_at DESC")
  end

  def show
  end

  def new
    @pin = current_user.pins.build
  end

  def create
    @pin = current_user.pins.build(pin_params)
    if @pin.save
      redirect_to @pin, notice: "Il Pin è stato creato correttamente!"
    else
      render 'new'
    end
  end

  def edit
    @pin = Pin.find(params[:id])
  end

  def update
    @pin = Pin.find(params[:id])
    if @pin.user == current_user
      if @pin.update(pin_params)
        redirect_to @pin, notice: "Il Pin è stato modificato correttamente!"
      else
        render 'edit'
      end
    else
      redirect_to @pin, notice: "Il Pin non può essere modificato perchè non sei l'autore."
    end
  end

  def destroy
    if @pin.user == current_user
      @pin.destroy
      redirect_to root_path
    else
      redirect_to @pin, notice: "Il Pin non può essere cancellato perchè non sei l'autore."
    end
  end

  def upvote
    @pin.upvote_by current_user
    redirect_back fallback_location: root_path
  end

  def downvote
    @pin.downvote_by current_user
    redirect_back fallback_location: root_path
  end


  private
  def pin_params
    params.require(:pin).permit(:title, :description, :image)
  end

  def find_pin
    @pin = Pin.find(params[:id])
  end
end
