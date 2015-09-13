class DivesController < ApplicationController
  before_action :logged_in_user,  only: [:create, :destroy]
  before_action :correct_user,    only: [:destroy]

  def create
    @dive = current_user.dives.build(dive_params)
    if @dive.save
        flash[:success] = "Dive logged!"
    else
        flash[:danger] = "Invalid dive parameters!"
    end
    respond_to do |format|
      # TODO handle flash over Ajax
      format.html { redirect_to request.referrer || root_url }
      format.js   { }
    end
  end
  
  def destroy
    @dive.destroy
    flash[:success] = "Dive deleted"
    redirect_to request.referrer || root_url
  end

  private
  
    def dive_params
      params.require(:dive).permit(:depth, :duration,
          :location, :buddy, :temperature, :divenumber,
          :starttime, :country)
    end
    
    def correct_user
      @dive = current_user.dives.find_by(id: params[:id])
      redirect_to root_url if @dive.nil?
    end
end
