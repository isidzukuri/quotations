class HomeController < ApplicationController
  def index
    flash[:error] = 'achtung!!!'
  end
end
