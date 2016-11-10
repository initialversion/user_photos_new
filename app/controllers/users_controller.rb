class UsersController < ApplicationController
  def index
    @q = User.ransack(params[:q])
    @users = @q.result(:distinct => true).includes(:photos).page(params[:page]).per(10)

    render("users/index.html.erb")
  end

  def show
    @photo = Photo.new
    @user = User.find(params[:id])

    render("users/show.html.erb")
  end

  def new
    @user = User.new

    render("users/new.html.erb")
  end

  def create
    @user = User.new

    @user.password = params[:password]
    @user.name = params[:name]

    save_status = @user.save

    if save_status == true
      redirect_to(:back, :notice => "User created successfully.")
    else
      render("users/new.html.erb")
    end
  end

  def edit
    @user = User.find(params[:id])

    render("users/edit.html.erb")
  end

  def update
    @user = User.find(params[:id])

    @user.password = params[:password]
    @user.name = params[:name]

    save_status = @user.save

    if save_status == true
      redirect_to(:back, :notice => "User updated successfully.")
    else
      render("users/edit.html.erb")
    end
  end

  def destroy
    @user = User.find(params[:id])

    @user.destroy

    if URI(request.referer).path == "/users/#{@user.id}"
      redirect_to("/", :notice => "User deleted.")
    else
      redirect_to(:back, :notice => "User deleted.")
    end
  end
end
