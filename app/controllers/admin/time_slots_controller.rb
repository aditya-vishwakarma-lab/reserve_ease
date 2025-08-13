class Admin::TimeSlotsController < Admin::BaseController
  before_action :set_table
  before_action :set_time_slot, only: [:show, :edit, :update, :destroy]

  def index
    @time_slots = @table.time_slots.includes(:reservation).order(:start_time)
  end

  def new
    @time_slot = @table.time_slots.new
  end

  def create
    @time_slot = @table.time_slots.new(time_slot_params)
    if @time_slot.save
      redirect_to admin_table_time_slots_path(@table), notice: 'Time slot created successfully.'
    else
      render :new
    end
  end

  def show

  end

  def edit
  end

  def update

  end

  def destroy
    @time_slot.destroy
    redirect_to admin_table_time_slots_path(@table), notice: 'Time slot deleted.'
  end

  private

  def set_time_slot
    @time_slot = @table.time_slots.find(params[:id])
  end

  def set_table
    @table = Table.find(params[:table_id])
  end

  def time_slot_params
    params.require(:time_slot).permit(:start_time, :end_time)
  end
end
