class CommentsController < ApplicationController

  def create
    @prototype = Prototype.find(params[:prototype_id])
    @comment = @prototype.comments.build(comment_params.merge(user: current_user))
    if @comment.save
      redirect_to prototype_path(@prototype)
    else
      render 'prototypes/show'
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    if user_signed_in?
      @comment = Comment.new
    end
    @comments = @prototype.comments
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id)
  end
end

