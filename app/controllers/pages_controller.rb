class PagesController < ApplicationController
  def media
    if user_signed_in?
      @social_posts = current_user.social_posts

      if @social_posts.empty?
        @message = "Wow, that's a very clean portfolio!"
      else
        @message = "Here's your portfolio:"
      end
    end
  end
end
