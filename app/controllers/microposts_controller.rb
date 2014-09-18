class MicropostsController < ApplicationController
	before_action :admin_user

	def create
		@micropost = current_user.microposts.build(micropost_params)
		if @micropost.save
			flash[:success] = "Nyhet skapat!"
		else
			render 'static_pages/home'
		end
	end

	def edit
	end

	def destroy
	end

	private
		def micropost_params
			params.require(:micropost).permit(:content)
		end
end