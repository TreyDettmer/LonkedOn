class UsersController < ApplicationController
  before_action :set_user
  def show
    @user = User.find(params[:id])
  end

  def edit

  end
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def follow
    current_user.send_follow_request_to(@user)
    @user.accept_follow_request_of(current_user)
    #redirect_to user_path(@user)

    update_follow_button
  end

  def unfollow
    current_user.unfollow(@user)
    #redirect_to user_path(@user)

    update_follow_button
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
    params.require(:user).permit(:headline, :location, :avatar)
  end
end
