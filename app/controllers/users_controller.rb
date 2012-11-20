class UsersController < ApplicationController

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])

    # TBA - test required!
    # set the user group against the new user (should have a 'current_group')
    @user.user_group = UserGroup.all.first

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, :notice => "Signed up!"
    else
      flash.now.alert = "Not signed up!"
      render "new"
    end
  end

end
