class UsersController < ApplicationController
  before_action :set_user
  def show
    @user = User.find(params[:id])
  end

  def edit
    return respond_to do |format|
      format.html { redirect_to social_posts_url}
    end
  end

  def update_user_profile
    @user = User.find(params[:id])
    if current_user && (current_user == @user || current_user.admin?)
      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            "#{helpers.dom_id(@user)}_header_section_frame",
            partial: "users/form",
            locals: {user: @user}
          )
        }
        format.html { redirect_to user_url(@user), notice: "Updating about was unsuccessful." }
      end
    else
      return respond_to do |format|
        format.html { redirect_to social_posts_url}
      end
    end
  end

  def update_about_section
    @user = User.find(params[:id])
    if current_user && (current_user == @user || current_user.admin?)
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
            "#{helpers.dom_id(@user)}_about_frame",
            partial: "users/about_form",
            locals: {user: @user}
          )
        }
        format.html { redirect_to user_url(@user), notice: "Updating about was unsuccessful." }
      end
    else
      return respond_to do |format|
        format.html { redirect_to social_posts_url}
      end
    end
  end

  def build_a_new_education_experience
    @user = User.find(params[:id])
    if current_user && (current_user == @user || current_user.admin?)
      @education_experience = @user.education_experiences.build
      respond_to do |format|

        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            "#{helpers.dom_id(@user)}_new_education_experience_frame",
            partial: "education_experiences/form",
            locals: {education_experience: @education_experience, user: @user}
          )
        }
        format.html { redirect_to user_url(@user), notice: "Education experience was unsuccessfully created." }
      end
    else
      return respond_to do |format|
        format.html { redirect_to social_posts_url}
      end
    end
  end

  def build_a_new_work_experience
    @user = User.find(params[:id])
    if current_user && (current_user == @user || current_user.admin?)
      @work_experience = @user.work_experiences.build
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
            "#{helpers.dom_id(@user)}_new_work_experience_frame",
            partial: "work_experiences/form",
            locals: {work_experience: @work_experience, user: @user}
          )
        }
        format.html { redirect_to user_url(@user), notice: "Work experience was unsuccessfully created." }
      end
    else
      return respond_to do |format|
        format.html { redirect_to social_posts_url}
      end
    end
  end
  def update
    if current_user && (current_user == @user || current_user.admin?)
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    else
      return respond_to do |format|
        format.html { redirect_to social_posts_url}
      end
    end
  end

  def follow
    if current_user
      current_user.send_follow_request_to(@user)
      @user.accept_follow_request_of(current_user)
      #redirect_to user_path(@user)

      update_follow_button
    end
  end

  def unfollow
    if current_user
      current_user.unfollow(@user)
      #redirect_to user_path(@user)

      update_follow_button
    end
  end
  
  def accept
    current_user.accept_follow_request_of(@user)
    #redirect_to user_path(@user)

    update_follow_button
  end

  def decline
    current_user.decline_follow_request_of(@user)
    #redirect_to user_path(@user)

    update_follow_button
 end

  def cancel
    current_user.remove_follow_request_for(@user)
    #redirect_to user_path(@user)

    update_follow_button
 end

 private

 def update_follow_button
  render turbo_stream:
    turbo_stream.replace("follow_button",
        partial: "users/follow_button",
        locals: {this_user: current_user, other_user: @user}
    )
 end

 def set_user

    @user = User.find(params[:id])
 end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:headline, :location, :avatar, :backdrop, :about)
  end
end
