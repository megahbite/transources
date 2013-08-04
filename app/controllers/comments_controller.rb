class CommentsController < ApplicationController
  def create
    debugger
    @comment = Comment.new(params[:comment].except(:anonymous))
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
  end
end
