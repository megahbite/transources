class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @comment = Comment.new(comment_params)
    authorize @comment
    @resource = Resource.find(params[:resource_id])

    @comment.resource = @resource

    if params[:comment][:anonymous] == "0"
      @comment.user_id = current_user.id
    end

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @resource, notice: 'Comment was successfully created.' }
        format.json { render json: @comment, status: :created, location: @resource }
      else
        format.html { render controller: "resource", action: "show" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize @comment
    @resource = Resource.find(params[:resource_id])

    @comment.destroy

    respond_to do |format|
      format.html { redirect_to @resource }
      format.json { head :no_content }
    end
  end

private

  def comment_params
    params.require(:comment).permit(:user_id, :text, :score, :resource_id).except(:anonymous)
  end  
end
