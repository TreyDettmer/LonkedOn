require "test_helper"

class SocialPostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @social_post = social_posts(:one)
  end

  test "should get index" do
    get social_posts_url
    assert_response :success
  end

  test "should get new" do
    get new_social_post_url
    assert_response :success
  end

  test "should create social_post" do
    assert_difference("SocialPost.count") do
      post social_posts_url, params: { social_post: { content: @social_post.content, title: @social_post.title } }
    end

    assert_redirected_to social_post_url(SocialPost.last)
  end

  test "should show social_post" do
    get social_post_url(@social_post)
    assert_response :success
  end

  test "should get edit" do
    get edit_social_post_url(@social_post)
    assert_response :success
  end

  test "should update social_post" do
    patch social_post_url(@social_post), params: { social_post: { content: @social_post.content, title: @social_post.title } }
    assert_redirected_to social_post_url(@social_post)
  end

  test "should destroy social_post" do
    assert_difference("SocialPost.count", -1) do
      delete social_post_url(@social_post)
    end

    assert_redirected_to social_posts_url
  end
end
