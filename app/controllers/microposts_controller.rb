class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: [:destroy]
  #respond_to    :html, :js # TODO requires gem responders
  
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash.now[:success] = "Micropost created!"
      redirect_to root_url unless request.xhr?
    else
      @feed_items = []
      render 'static_pages/home' unless request.xhr?
    end
    
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def destroy
    @micropost.destroy
    flash.now[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url unless request.xhr?
    
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  private
  
    def micropost_params
      params.require(:micropost).permit(:content, :picture)
    end
    
    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end

end
