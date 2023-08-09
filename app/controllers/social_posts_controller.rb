class SocialPostsController < ApplicationController
  before_action :set_social_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  # GET /social_posts or /social_posts.json
  def index
    @social_posts = SocialPost.all
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
        # format.html { redirect_to social_post_url(@social_post), notice: "Social post was successfully created." }
        # format.json { render :show, status: :created, location: @social_post }
        format.html { redirect_to action:"index"}
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
