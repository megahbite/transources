class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @comment = Comment.new(comment_params)
    authorize @comment
    @resource = Resource.find(params[:resource_id])

    @comment.resource = @resource
    @comment.user_ip = request.remote_ip
    @comment.user_agent = request.headers["User-Agent"]
    @comment.referrer = request.headers["Referer"]


    if params[:comment][:anonymous] == "0"
      @comment.user_id = current_user.id
    end

    @comment.spam = @comment.spam?

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
    @resource = Resource.find(params[:resource_id]) if params[:resource_id].present?

    @comment.destroy

    respond_to do |format|
      format.html {
        if @resource
          redirect_to @resource
        else
          redirect_to manage_comments_path
        end
      }
      format.json { head :no_content }
    end
  end

  def manage
    @comments = Comment.order(created_at: :desc)
    if params[:resource_id].present?
      @comments = @comments.where(resource_id: params[:resource_id])
      @resource = Resource.find(params[:resource_id])
    end

    if params[:spam].present?
      @comments = @comments.where(spam: ActiveRecord::ConnectionAdapters::Column.value_to_boolean(params[:spam]))
    end
    authorize @comments
  end

  def spam
    @comment = Comment.find(params[:id])
    authorize @comment
    @comment.spam = @comment.spam!
    @comment.save
    redirect_to :back
  end

  def ham
    @comment = Comment.find(params[:id])
    authorize @comment
    @comment.spam = @comment.ham!
    @comment.save
    redirect_to :back
  end

private

  def comment_params
    params.require(:comment).permit(:user_id, :text, :score, :resource_id).except(:anonymous)
  end
end
