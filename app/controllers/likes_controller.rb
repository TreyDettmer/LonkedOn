class LikesController < ApplicationController
  def create
    if current_user
      @like = current_user.likes.new(like_params)
      if !@like.save
        flash[:alert] = "You already liked this"
      end
      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            "#{helpers.dom_id(@like.social_post)}_like_button",
            partial: "social_posts/like_button",
            locals: {this_user: current_user, social_post: @like.social_post}
          )
        }
        format.html { redirect_to social_posts_url, notice: "Like was created successfully"}
      end
    else
      return respond_to do |format|
        format.html { redirect_to social_posts_url}
      end
    end
  end

  def destroy
    if current_user
      @like = current_user.likes.find(params[:id])
      @like.destroy
      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            "#{helpers.dom_id(@like.social_post)}_like_button",
            partial: "social_posts/like_button",
            locals: {this_user: current_user, social_post: @like.social_post}
          )
        }
        format.html { redirect_to social_posts_url, notice: "Like was deleted successfully"}
      end
    else
      return respond_to do |format|
        format.html { redirect_to social_posts_url}
      end
    end
  end

  private

  def like_params
    params.require(:like).permit(:social_post_id)
  end
end
