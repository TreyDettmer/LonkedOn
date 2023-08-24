class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]

  # GET /comments or /comments.json
  def index
    @comments = Comment.all
    respond_to do |format|
      format.html { redirect_to social_posts_url}
    end
  end

  # GET /comments/1 or /comments/1.json
  def show
    respond_to do |format|
      format.html { redirect_to social_posts_url}
    end
  end

  # GET /comments/new
  def new
    respond_to do |format|
      format.html { redirect_to social_posts_url}
    end
  end

  # GET /comments/1/edit
  def edit
    respond_to do |format|
      format.html { redirect_to social_posts_url}
    end
  end

  # POST /comments or /comments.json
  def create;
    @comment = Comment.new(comment_params)  
    @social_post = SocialPost.find(@comment.social_post_id)

    respond_to do |format|
      if @comment.save
        # format.turbo_stream {
        #   render turbo_stream: turbo_stream.prepend(
        #     "#{helpers.dom_id(@social_post)}_comments_frame",
        #     partial: "comments/comment",
        #     locals: {comment: @comment}
        #   )
        # }
        # format.turbo_stream {
        #   render turbo_stream: turbo_stream.replace(
        #     "#{helpers.dom_id(@social_post)}_comment_frame",
        #     partial: "comments/nothing",
        #   )
        # }
        format.html { redirect_to social_posts_url, notice: "Comment was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      format.html { redirect_to social_posts_url}
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    if @comment.user_id == current_user.id || current_user.admin?
      

      respond_to do |format|
        if @comment.destroy
          format.html { redirect_to social_posts_url, notice: "Comment was successfully destroyed." }
          format.json { head :no_content }
        else
          format.html { redirect_to social_posts_url, notice: "Comment was unsuccessfully destroyed." }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end

      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:text, :user_id, :social_post_id)
    end
end
