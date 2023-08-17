class JobPostsController < ApplicationController
  before_action :set_job_post, only: %i[ show edit update destroy ]
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

  # GET /job_posts or /job_posts.json
  def index
    @job_posts = JobPost.order(:created_at => :asc)
    @pagy, @job_posts = pagy_countless(@job_posts, items: 3)
    @teststring = "index"
  end

  def change_selected
    @selected_job_post = JobPost.find(params[:id])
    @teststring = "show"
    puts @selected_job_post.title
    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: turbo_stream.replace(
          "selected-job-container",
          partial: "job_posts/selected_job_post",
          locals: {job_post: @selected_job_post}
        )
      }
      format.html { redirect_to job_posts_url, notice: "Job post was unsuccessfully selected" }
    end
  end

  # GET /job_posts/1 or /job_posts/1.json
  def show
    @selected_job_post = JobPost.find(params[:id])
    @teststring = "show"
    puts @selected_job_post.title
    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: turbo_stream.replace(
          "selected-job-container",
          partial: "job_posts/selected_job_post",
          locals: {job_post: @selected_job_post}
        )
      }
    end
  end

  # GET /job_posts/new
  def new
    @job_post = JobPost.new
  end

  # GET /job_posts/1/edit
  def edit
  end

  # POST /job_posts or /job_posts.json
  def create
    @job_post = JobPost.new(job_post_params)

    respond_to do |format|
      if @job_post.save
        format.html { redirect_to job_post_url(@job_post), notice: "Job post was successfully created." }
        format.json { render :show, status: :created, location: @job_post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @job_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /job_posts/1 or /job_posts/1.json
  def update
    respond_to do |format|
      if @job_post.update(job_post_params)
        format.html { redirect_to job_post_url(@job_post), notice: "Job post was successfully updated." }
        format.json { render :show, status: :ok, location: @job_post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @job_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /job_posts/1 or /job_posts/1.json
  def destroy
    
    @job_post.destroy

    respond_to do |format|
      format.html { redirect_to job_posts_url, notice: "Job post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job_post
      @job_post = JobPost.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def job_post_params
      params.require(:job_post).permit(:title, :description, :location, :company_id)
    end
end
