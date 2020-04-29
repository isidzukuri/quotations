class ScansController < ApplicationController
  def index
    @scans = Scan.all
    # TODO: add paginator
  end

  def new
    @scan = Scan.new
  end

  def create
    @scan = Scan.new(scans_params)

    if @scan.save
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

  def scans_params
    params.require(:scan).permit(:image)
  end
end
