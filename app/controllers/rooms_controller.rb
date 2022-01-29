class RoomsController < ApplicationController
  before_action :authenticate_user!, except: :search

  def index
    @rooms = Room.all
    @user = current_user
  end

  def new
    @room = Room.new
    @user = current_user
  end

  def create
    @room = Room.new(room_params)
    @room.user_id = current_user.id
    @user = current_user
    if @room.save
      flash[:notice] = "ルームを新規登録しました"
      redirect_to :rooms
    else
      render "new"
    end
  end

  def show
    @user = current_user
    @room = Room.find(params[:id])
    @room.user_id = current_user.id
    @reservation = Reservation.new
    @reservation.room_id = @room.id
  end

  def search
    @rooms = Room.search(params[:search])
    @user = current_user
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def room_params
    params.require(:room).permit(:room_name, :introduction, :price, :address, :image, :user_id)
  end

end
