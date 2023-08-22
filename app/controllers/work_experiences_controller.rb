class WorkExperiencesController < ApplicationController
  before_action :set_work_experience, only: %i[ show edit update destroy ]

  # GET /work_experiences or /work_experiences.json
  def index
    @work_experiences = WorkExperience.all
  end

  # GET /work_experiences/1 or /work_experiences/1.json
  def show
  end

  # GET /work_experiences/new
  def new
    if current_user
      @work_experience = WorkExperience.new
      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            "#{helpers.dom_id(current_user)}_work_experiences_frame",
            partial: "work_experiences/form",
            locals: {user: current_user}
          )
        }
      end
    else
      return respond_to do |format|
        format.html { redirect_to social_posts_url}
      end
    end
  end

  def modify_work_experience
    
    @work_experience = WorkExperience.find(params[:id])
    if current_user && (current_user == @work_experience.user || current_user.admin?)
      respond_to do |format|
        # format.turbo_stream {
        #   render turbo_stream: turbo_stream.replace(
        #     "#{helpers.dom_id(@user)}_work_experiences_frame",
        #     partial: "work_experiences/empty_feed",
        #     locals: {user: @user}
        #   )
        # }
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            "#{helpers.dom_id(@work_experience.user)}_new_work_experience_frame",
            partial: "work_experiences/form",
            locals: {work_experience: @work_experience, user: @work_experience.user}
          )
        }
        format.html { redirect_to user_url(@work_experience.user), notice: "Work experience was unsuccessfully edited." }
      end
    else
      return respond_to do |format|
        format.html { redirect_to social_posts_url}
      end
    end
  end
  # GET /work_experiences/1/edit
  def edit
    
  end

  # POST /work_experiences or /work_experiences.json
  def create
    @work_experience = WorkExperience.new(work_experience_params)
    @user = User.find(@work_experience.user_id)
    if current_user && (current_user == @user || current_user.admin?)
      @user.save
      respond_to do |format|
        if @work_experience.save

          # format.turbo_stream {
          #   render turbo_stream: turbo_stream.replace(
          #     "#{helpers.dom_id(@user)}_new_work_experience_frame",
          #     partial: "work_experiences/empty_new_work_experience",
          #     locals: {user: @user}
          #   )
          # }

          # format.turbo_stream {
          #   render turbo_stream: turbo_stream.prepend(
          #     "#{helpers.dom_id(@user)}_work_experiences_frame",
          #     partial: "work_experiences/work_experience",
          #     locals: {work_experience: @work_experience}
          #   )
          # }


          format.html { redirect_to user_url(@user), notice: "Work experience was successfully created." }
          format.json { render :show, status: :created, location: @work_experience }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @work_experience.errors, status: :unprocessable_entity }
        end
      end
    else
      return respond_to do |format|
        format.html { redirect_to social_posts_url}
      end
    end
  end

  # PATCH/PUT /work_experiences/1 or /work_experiences/1.json
  def update
    if current_user && (current_user == @work_experience.user || current_user.admin?)
      respond_to do |format|
        if @work_experience.update(work_experience_params)


          # format.turbo_stream {
          #   render turbo_stream: turbo_stream.replace(
          #     "#{helpers.dom_id(@work_experience.user)}_new_work_experience_frame",
          #     partial: "work_experiences/empty_new_work_experience",
          #     locals: {user: @work_experience.user}
          #   )
          # }

          # format.turbo_stream {
          #   render turbo_stream: turbo_stream.replace(
          #     "#{helpers.dom_id(@work_experience)}",
          #     partial: "work_experiences/work_experience",
          #     locals: {work_experience: @work_experience}
          #   )
          # }


          format.html { redirect_to user_url(@work_experience.user), notice: "Work experience was successfully updated." }
          format.json { render :show, status: :ok, location: @work_experience.user }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @work_experience.errors, status: :unprocessable_entity }
        end
      end
    else
      return respond_to do |format|
        format.html { redirect_to social_posts_url}
      end
    end
  end

  # DELETE /work_experiences/1 or /work_experiences/1.json
  def destroy
    if current_user && (current_user == @work_experience.user || current_user.admin?)
      @work_experience.destroy

      respond_to do |format|
        format.html { redirect_to user_url(@work_experience.user), notice: "Work experience was successfully destroyed." }
        format.json { head :no_content }
      end
    else
      return respond_to do |format|
        format.html { redirect_to social_posts_url}
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_work_experience
      @work_experience = WorkExperience.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def work_experience_params
      params.require(:work_experience).permit(:title, :user_id, :company_id, :location, :start_date, :end_date, :description)
    end
end
