class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]


  def index
    @prototypes = Prototype.all
  end
  
  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
  
    if @prototype.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @user = @prototype.user 
    if user_signed_in?
      @comment = Comment.new
    end
  end

  def edit
    @prototype = Prototype.find(params[:id])
    if current_user != @prototype.user
      redirect_to root_path
    end
  end

  def update
    @prototype = Prototype.find(params[:id])

    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    @prototype.comments.destroy_all
    unless current_user == @prototype.user
      redirect_to root_path
    end
    @prototype.destroy
    redirect_to root_path
  end



  private
  def prototype_params
    params.require(:prototype).permit(:image, :title, :catch_copy, :concept).merge(user_id: current_user.id)
  end

   def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  

end


