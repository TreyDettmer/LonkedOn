class EducationExperiencesController < ApplicationController
  before_action :set_education_experience, only: %i[ show edit update destroy ]

  # GET /education_experiences or /education_experiences.json
  def index
    @education_experiences = EducationExperience.all
    respond_to do |format|
      format.html { redirect_to social_posts_url}
    end
  end

  # GET /education_experiences/1 or /education_experiences/1.json
  def show
    respond_to do |format|
      format.html { redirect_to social_posts_url}
    end
  end

  # GET /education_experiences/new
  def new
    if current_user

      @education_experience = EducationExperience.new
      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            "#{helpers.dom_id(current_user)}_education_experiences_frame",
            partial: "education_experiences/form",
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

  def modify_education_experience
    if current_user
      @education_experience = EducationExperience.find(params[:id])
      respond_to do |format|

        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            "#{helpers.dom_id(@education_experience.user)}_new_education_experience_frame",
            partial: "education_experiences/form",
            locals: {education_experience: @education_experience, user: @education_experience.user}
          )
        }
        format.html { redirect_to user_url(@education_experience.user), notice: "Education experience was unsuccessfully edited." }
      end
    else
      return respond_to do |format|
        format.html { redirect_to social_posts_url}
      end
    end
  end

  # GET /education_experiences/1/edit
  def edit
  end

  # POST /education_experiences or /education_experiences.json
  def create
    if current_user
      @education_experience = EducationExperience.new(education_experience_params)
      @user = User.find(@education_experience.user_id)
      @user.save
      respond_to do |format|
        if @education_experience.save

          # format.turbo_stream {
          #   render turbo_stream: turbo_stream.replace(
          #     "#{helpers.dom_id(@user)}_new_education_experience_frame",
          #     partial: "education_experiences/empty_new_education_experience",
          #     locals: {user: @user}
          #   )
          # }

          # format.turbo_stream {
          #   render turbo_stream: turbo_stream.prepend(
          #     "#{helpers.dom_id(@user)}_education_experiences_frame",
          #     partial: "education_experiences/education_experience",
          #     locals: {education_experience: @education_experience}
          #   )
          # }


          format.html { redirect_to user_url(@user), notice: "Education experience was successfully created." }
          format.json { render :show, status: :created, location: @education_experience }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @education_experience.errors, status: :unprocessable_entity }
        end
      end
    else
      return respond_to do |format|
        format.html { redirect_to social_posts_url}
      end
    end
  end

  # PATCH/PUT /education_experiences/1 or /education_experiences/1.json
  def update
    if current_user && (@education_experience.user == current_user || current_user.admin?)
      respond_to do |format|
        if @education_experience.update(education_experience_params)


          # format.turbo_stream {
          #   render turbo_stream: turbo_stream.replace(
          #     "#{helpers.dom_id(@education_experience.user)}_new_education_experience_frame",
          #     partial: "education_experiences/empty_new_education_experience",
          #     locals: {user: @education_experience.user}
          #   )
          # }

          # format.turbo_stream {
          #   render turbo_stream: turbo_stream.replace(
          #     "#{helpers.dom_id(@education_experience)}",
          #     partial: "education_experiences/education_experience",
          #     locals: {education_experience: @education_experience}
          #   )
          # }
          puts "updated!"

          format.html { redirect_to user_url(@education_experience.user), notice: "Education experience was successfully updated." }
          format.json { render :show, status: :ok, location: @education_experience.user }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @education_experience.errors, status: :unprocessable_entity }
        end
      end
    else
      return respond_to do |format|
        format.html { redirect_to social_posts_url}
      end
    end
  end

  # DELETE /education_experiences/1 or /education_experiences/1.json
  def destroy
    if current_user && (@education_experience.user == current_user || current_user.admin?)
      @education_experience.destroy

      respond_to do |format|
        format.html { redirect_to education_experiences_url, notice: "Education experience was successfully destroyed." }
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
    def set_education_experience
      @education_experience = EducationExperience.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def education_experience_params
      params.require(:education_experience).permit(:school, :field_of_study, :user_id, :start_date, :end_date, :description)
    end
end
