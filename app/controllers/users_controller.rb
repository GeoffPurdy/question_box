class UsersController < ApplicationController
  before_action :current_user
  def new
    @user = User.new
  end

  def index
    @user = @current_user
  end

  def show
    @user = User.new
  end

  def update
    # setup for save
    if @current_user.update(:tag_list)
      flash[:notice] = 'Your tag list was successfully created.'
      redirect_to root_path
    else
      render :action => "edit"
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:current_user_id] = @user.id
      redirect_to root_path, success: "You are successfully registered."
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :tag_list)
  end
end
