class UsersController < ApplicationController

  before_action :authenticate_user!, only: [:show, :edit]
  def show
    @user = User.find(params[:id])
    @prototypes = @user.prototypes
  end

  def edit
  end


end
