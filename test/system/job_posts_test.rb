require "application_system_test_case"

class JobPostsTest < ApplicationSystemTestCase
  setup do
    @job_post = job_posts(:one)
  end

  test "visiting the index" do
    visit job_posts_url
    assert_selector "h1", text: "Job posts"
  end

  test "should create job post" do
    visit job_posts_url
    click_on "New job post"

    fill_in "Description", with: @job_post.description
    fill_in "Location", with: @job_post.location
    fill_in "Title", with: @job_post.title
    click_on "Create Job post"

    assert_text "Job post was successfully created"
    click_on "Back"
  end

  test "should update Job post" do
    visit job_post_url(@job_post)
    click_on "Edit this job post", match: :first

    fill_in "Description", with: @job_post.description
    fill_in "Location", with: @job_post.location
    fill_in "Title", with: @job_post.title
    click_on "Update Job post"

    assert_text "Job post was successfully updated"
    click_on "Back"
  end

  test "should destroy Job post" do
    visit job_post_url(@job_post)
    click_on "Destroy this job post", match: :first

    assert_text "Job post was successfully destroyed"
  end
end
