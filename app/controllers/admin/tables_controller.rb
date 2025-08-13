# app/controllers/admin/tables_controller.rb
class Admin::TablesController < Admin::BaseController
  before_action :set_table, only: [:show, :edit, :update, :destroy]

  def index
    @tables = Table.all.order(:name)
  end

  def show
    @time_slots = @table.time_slots.includes(:reservation).order(:start_time)
  end

  def new
    @table = Table.new
  end

  def create
    @table = Table.new(table_params)
    if @table.save
      redirect_to admin_tables_path, notice: 'Table created successfully.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @table.update(table_params)
      redirect_to admin_tables_path, notice: 'Table updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    if @table.time_slots.any?
      redirect_to admin_tables_path, alert: 'Cannot delete table with existing time slots.'
    else
      @table.destroy
      redirect_to admin_tables_path, notice: 'Table deleted successfully.'
    end
  end

  private

  def set_table
    @table = Table.find(params[:id])
  end

  def table_params
    params.require(:table).permit(:name, :capacity, :area, :features)
  end
end
