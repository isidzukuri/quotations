# frozen_string_literal: true

class ScansController < ApplicationController
  
  def index
    @items = Scan.all.paginate(page: params[:page], per_page: 20)
  end

  def new
    @scan = Scan.new
  end

  def create
    result = Scans::Create.new(scan_params).call

    if result.success?
      flash[:success] = I18n.t('scan.created_successfully')
      redirect_to scans_path
    else
      flash[:danger] = I18n.t(:smtng_went_wrong)
      render :new
    end
  end

  def show
    @scan = Scan.find(params[:id])
  end

  def destroy
    @scan = Scan.find(params[:id])

    if @scan.destroy
      flash[:success] = I18n.t('scan.deleted_successfully')
      redirect_to scans_path
    else
      flash[:danger] = I18n.t(:smtng_went_wrong)
      render :show
    end
  end

  private

  def scan_params
    params.require(:scan).permit(:image, :do_not_scan)
  end
end
