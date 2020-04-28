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
      flash[:success] = 'Scan has been created'
      redirect_to scans_path
    else
      flash[:danger] = 'Something went wrong'
      render :new
    end
  end

  def show
    @scan = Scan.find(params[:id])
  end

  # def edit
  # end

  # def update
  # end

  # def destroy
  # end

  private

  def scans_params
    params.require(:scan).permit(:image)
  end
end
