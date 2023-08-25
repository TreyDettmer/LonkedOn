class SocialPostsController < ApplicationController
  before_action :set_social_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show, :show_comments]
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
    @social_posts = SocialPost.order(:created_at => :desc)
    @pagy, @social_posts = pagy_countless(@social_posts, items: 10)
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
    if current_user
      @social_post.punch(request)
    else
      return respond_to do |format|
        format.html { redirect_to social_posts_url}
      end
    end
  end

  # GET /social_posts/new
  def new
    if current_user
      @social_post = SocialPost.new
    else
      return respond_to do |format|
        format.html { redirect_to social_posts_url}
      end
    end
  end

  # GET /social_posts/1/edit
  def edit
    return respond_to do |format|
      format.html { redirect_to social_posts_url}
    end
  end

  def build_a_new_social_post
    @user = User.find(params[:id])
    @social_post = @user.social_posts.build
    respond_to do |format|

      format.turbo_stream {
        render turbo_stream: turbo_stream.replace(
          "#{helpers.dom_id(current_user)}_new_post_bar",
          partial: "social_posts/form",
          locals: {social_post: @social_post, user: @user}
        )
      }
      format.html { redirect_to social_posts_url, notice: "Social post was unsuccessfully created." }
    end
  end

  # POST /social_posts or /social_posts.json
  def create
    if current_user
      @social_post = SocialPost.new(social_post_params)
      @user = User.find(@social_post.user_id)
      @user.save
      respond_to do |format|
        if @social_post.save


          format.html { redirect_to social_posts_url, notice: "Social post was successfully created." }
          format.json { render :show, status: :created, location: @social_post }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @social_post.errors, status: :unprocessable_entity }
        end
      end
    else
      return respond_to do |format|
        format.html { redirect_to social_posts_url}
      end
    end
  end

  # PATCH/PUT /social_posts/1 or /social_posts/1.json
  def update
    if current_user
      if @social_post.user_id.to_s == current_user.id.to_s
        respond_to do |format|
          if @social_post.update(social_post_params)
            format.html { redirect_to social_post_url(@social_post), notice: "Social post was successfully updated." }
            format.json { render :show, status: :ok, location: @social_post }
          else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: @social_post.errors, status: :unprocessable_entity }
          end
        end
      else
        return respond_to do |format|
          format.html { redirect_to social_posts_url}
        end
      end
    else
      return respond_to do |format|
        format.html { redirect_to social_posts_url}
      end
    end
  end

  # DELETE /social_posts/1 or /social_posts/1.json
  def destroy
    if (@social_post.user_id.to_s == current_user.id.to_s) || current_user.admin?
      @social_post.destroy
      #broadcast_to_all("social_post_deleted", @social_post.id)
        
      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: turbo_stream.remove(
            "#{helpers.dom_id(@social_post)}"
          )
        }
        format.html { redirect_to job_posts_url, notice: "Social post was successfully destroyed." }
        format.json { head :no_content }
      end
      
      #redirect_to social_posts_path, notice: "Social post was successfully deleted."
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

    def broadcast_to_all(action, record_id)
      turbo_stream.append("social_posts", render(partial: "empty_social_post", locals: { social_post: SocialPost.new }))
      turbo_stream.remove("social_post_#{record_id}")
    end
end
