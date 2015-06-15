# require '/user.rb'
class PinsController < ApplicationController
  before_action :set_pin, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, :unless => :devise_controller?, except: [:index, :show]

  def index
    if params[:search]
     # @pins = Pin.text_search(params[:search]).order("created_at DESC").paginate(:page => params[:page],:per_page => 8)
     @pins = Pin.search(params[:search]).order("created_at DESC").paginate(:page => params[:page],:per_page => 8)
     @user = User.search(params[:search]).order("created_at DESC").paginate(:page => params[:page],:per_page => 1)
    else
     @pins = Pin.all.order("created_at DESC").paginate(:page => params[:page],:per_page => 8)
     @user = User.all.order("created_at DESC").paginate(:page => params[:page],:per_page => 2)
    end

    # @pins = Pin.search(params[:search]).order("created_at DESC").paginate(:page => params[:page],:per_page => 1)

    # @pins = Pin.all.order("created_at DESC").paginate(:page => params[:page],:per_page => 1)
    # @pins = Pin.search(params[:search])
  end

  def show
  end

  def new
    @pin = current_user.pins.build
  end

  def edit
  end

  def create
    @pin = current_user.pins.build(pin_params)
    if @pin.save
      redirect_to @pin, notice: 'Pin was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @pin.update(pin_params)
      redirect_to @pin, notice: 'Pin was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @pin.destroy
    redirect_to pins_url
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_pin
    @pin = Pin.find(params[:id])
  end

  def correct_user
    @pin = current_user.pins.find_by(id: params[:id])
    redirect_to pins_path, notice: "Not authorised to edit this pin" if @pin.nil?
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def pin_params
    params.require(:pin).permit(:description, :image)
  end
end

