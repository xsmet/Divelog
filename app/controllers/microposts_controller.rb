class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: [:destroy]
  
  def create
    @micropost = current_user.microposts.build(micropost_params)

    respond_to do |format|
      if @micropost.save
        flash_message(:success, "Micropost created!")
        format.html { redirect_to request.referrer || root_url }
        format.js
      else
        flash_message(:danger, "Could not save micropost")
        format.html { 
          # needed on static_pages/home, specified in StaticPagesController
          @dive = current_user.dives.build
          @feed_items = current_user.feed.paginate(page: params[:page])
          render 'static_pages/home'
        }
        format.js
      end
    end
  end
  
  def destroy
    @micropost.destroy
    flash_message(:success, "Micropost deleted")
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
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
