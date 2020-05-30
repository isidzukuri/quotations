# frozen_string_literal: true

class QuotationsController < ApplicationController
  def index
    @items = Quotation.all.paginate(page: params[:page], per_page: 20)
  end

  def new
    @quotation = Quotation.new
  end

  def create
    result = Quotations::Create.new(quotation_params).call
    ap quotation_params
    raise

    if result.success?
      flash[:success] = I18n.t('quotation.created_successfully')
      redirect_to scans_path
    else
      flash[:danger] = I18n.t(:smtng_went_wrong)
      # add errors to the flash
      render :new
    end
  end

  # def show
  #   @scan = Scan.find(params[:id])
  # end

  # def destroy
  #   @scan = Scan.find(params[:id])

  #   if @scan.destroy
  #     flash[:success] = I18n.t('scan.deleted_successfully')
  #     redirect_to scans_path
  #   else
  #     flash[:danger] = I18n.t(:smtng_went_wrong)
  #     render :show
  #   end
  # end

  # private

  def quotation_params
    params.require(:quotation).permit(:language, :page, :percent, :url, :text, scan: [:image, :do_not_scan] )

    # params.require(:scan).permit(:image, :do_not_scan)
  end
end
