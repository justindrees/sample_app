class StaticPagesController < ApplicationController
  def home
  end

  def help
  end

  def about
  end

  def contact
  end

  def news
    @user = User.find_by(email: "styrelsen@example.com")
    @microposts = @user.microposts.paginate(page: params[:page])
    @micropost = @user.microposts.build if admin_user?
  end
end
