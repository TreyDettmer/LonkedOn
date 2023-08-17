class SocialPostsController < ApplicationController
  before_action :set_social_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  helper_method :time_since_creation
  include Pagy::Backend


  def time_since_creation(this_post)
    time_in_minutes = ((Date.today.to_time - this_post.created_at.to_time) / 60.0)
    if time_in_minutes >= 60
      time_in_hours = time_in_minutes / 60.0
      if time_in_hours >= 24
        time_in_days = time_in_hours / 24.0
        return time_in_days.round().to_s() + " days"
      end
      return time_in_hours.round().to_s() + " hrs"
    end
    return time_in_minutes.round().to_s() + " min"
  end
  # GET /social_posts or /social_posts.json
  def index
    @social_posts = SocialPost.order(:created_at => :asc)
    @pagy, @social_posts = pagy_countless(@social_posts, items: 3)
  end

  def start_a_comment
    @social_post = SocialPost.find(params[:id])
    @comment = @social_post.comments.build
    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: turbo_stream.replace(
          "#{helpers.dom_id(@social_post)}_comment_frame",
          partial: "comments/form",
          locals: {social_post: @social_post, comment: @comment,user: current_user}
        )
      }
      format.html { redirect_to social_posts_url, notice: "Social post comment started unsuccessfully" }
    end
  end
  def show_comments
    @social_post = SocialPost.find(params[:id])
    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: turbo_stream.replace(
          "#{helpers.dom_id(@social_post)}_comments_frame",
          partial: "social_posts/comments_feed",
          locals: {social_post: @social_post}
        )
      }
      format.html { redirect_to social_posts_url, notice: "Social post showing comments started unsuccessfully" }
    end
  end

  # GET /social_posts/1 or /social_posts/1.json
  def show
    @social_post.punch(request)
  end

  # GET /social_posts/new
  def new
    @social_post = SocialPost.new
  end

  # GET /social_posts/1/edit
  def edit
  end

  # POST /social_posts or /social_posts.json
  def create
    @social_post = SocialPost.new(social_post_params)

    respond_to do |format|
      if @social_post.save

        format.turbo_stream {
          render turbo_stream: turbo_stream.prepend(
            "social_posts",
            partial: "social_posts/social_post",
            locals: {social_post: @social_post}
          )
        }
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            "#{helpers.dom_id(SocialPost.new)}_form",
            partial: "social_posts/form",
            locals: {social_post: SocialPost.new}
          )
        }
        format.html { redirect_to social_posts_url, notice: "Post was successfully created!"}
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @social_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /social_posts/1 or /social_posts/1.json
  def update
    if @social_post.user_id == current_user.id
      respond_to do |format|
        if @social_post.update(social_post_params)
          format.html { redirect_to social_post_url(@social_post), notice: "Social post was successfully updated." }
          format.json { render :show, status: :ok, location: @social_post }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @social_post.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /social_posts/1 or /social_posts/1.json
  def destroy
    if @social_post.user_id == current_user.id
      @social_post.destroy

      respond_to do |format|
        format.html { redirect_to social_posts_url, notice: "Social post was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_social_post
      @social_post = SocialPost.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def social_post_params
      params.require(:social_post).permit(:title, :content, :image, :user_id)
    end
end
