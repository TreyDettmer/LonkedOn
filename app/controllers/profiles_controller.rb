class ProfilesController < ApplicationController
  def index
    # @users = users
    # @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)
  end

  # def users
  #   query = User.ransack(first_name_cont: search_query)

  #   @users = query.result(distance: true)
  # end

  # def search_query
  #   params[:query]
  # end
end
