require "application_system_test_case"

class SocialPostsTest < ApplicationSystemTestCase
  setup do
    @social_post = social_posts(:one)
  end

  test "visiting the index" do
    visit social_posts_url
    assert_selector "h1", text: "Social posts"
  end

  test "should create social post" do
    visit social_posts_url
    click_on "New social post"

    fill_in "Content", with: @social_post.content
    fill_in "Title", with: @social_post.title
    click_on "Create Social post"

    assert_text "Social post was successfully created"
    click_on "Back"
  end

  test "should update Social post" do
    visit social_post_url(@social_post)
    click_on "Edit this social post", match: :first

    fill_in "Content", with: @social_post.content
    fill_in "Title", with: @social_post.title
    click_on "Update Social post"

    assert_text "Social post was successfully updated"
    click_on "Back"
  end

  test "should destroy Social post" do
    visit social_post_url(@social_post)
    click_on "Destroy this social post", match: :first

    assert_text "Social post was successfully destroyed"
  end
end
