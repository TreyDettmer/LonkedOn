class ApplicationsController < ApplicationController
  def create
    @application = current_user.applications.new(application_params)
    if !@application.save
      flash[:alert] = "You already liked this"
    end
    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: turbo_stream.replace(
          "selected_job_post_application_button",
          partial: "job_posts/application_button",
          locals: {this_user: current_user, job_post: @application.job_post}
        )
      }
      format.html { redirect_to job_posts_url, notice: "application was created successfully"}
    end
  end

  def destroy
    @application = current_user.applications.find(params[:id])
    @application.destroy
    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: turbo_stream.replace(
          "selected_job_post_application_button",
          partial: "job_posts/application_button",
          locals: {this_user: current_user, job_post: @application.job_post}
        )
      }
      format.html { redirect_to job_posts_url, notice: "Like was deleted successfully"}
    end
  end

  def application_params
    params.require(:application).permit(:job_post_id)
  end
end
