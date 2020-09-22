# frozen_string_literal: true

class QuotationsController < ApplicationController
  def index
    @items = Quotation.all.paginate(page: params[:page], per_page: 20)
  end

  def new
    @quotation = Quotation.new(authors: [Author.new])
  end

  def create
    # ap quotation_params
    result = Quotations::Create.new(quotation_params).call

    if result.success?
      flash[:success] = I18n.t('quotation.created_successfully')
      redirect_to quotations_path
    else
      flash[:error] = HashToFlash.new(result.errors).call
      @quotation = result[:quotation]
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
    params.require(:quotation).permit(:language, :page, :percent, :url, :text, scan: [:image, :do_not_scan], authors: [[:id, :full_name]] )
    # , authors: [[:id, :full_name]]
    # , book: [:id, :title]
  end
end
