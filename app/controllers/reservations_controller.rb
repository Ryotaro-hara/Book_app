class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reservations = Reservation.all
    @user = current_user
  end

  def show
  end

  def new
    @user = current_user
    @reservation = Reservation.new(reservation_params)
    @reservation.user_id = current_user.id

    if @reservation.check_in.nil? || @reservation.check_out.nil?
      redirect_to @reservation.room, notice: "日付を指定してください。"
    elsif @reservation.check_out < Date.today || @reservation.check_in < Date.today
      redirect_to @reservation.room, notice: "今日より過去の日付は指定できません。"
    elsif @reservation.check_out == @reservation.check_in
      redirect_to @reservation.room, notice: "同じ日付は指定できません。"
    elsif @reservation.check_out < @reservation.check_in
      redirect_to @reservation.room, notice: "チェックインより後の日付を指定してください。"
    elsif @reservation.customer == nil
      redirect_to @reservation.room, notice: "人数を指定してください。"
    else
      @reservation.total_day = @reservation.amount_days.to_i
      @reservation.total_amount = @reservation.amount_price.to_i
      @reservation.save
    end
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.user_id = current_user.id
    @room = Room.find(params[:id])
    @reservation.room_id = @room.id
  end

  def complete
    @user = current_user
    @reservation = Reservation.new(reservation_params)
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out, :customer, :total_day, :total_amount, :user_id, :room_id)
  end

end
