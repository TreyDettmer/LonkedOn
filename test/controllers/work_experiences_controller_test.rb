require "test_helper"

class WorkExperiencesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @work_experience = work_experiences(:one)
  end

  test "should get index" do
    get work_experiences_url
    assert_response :success
  end

  test "should get new" do
    get new_work_experience_url
    assert_response :success
  end

  test "should create work_experience" do
    assert_difference("WorkExperience.count") do
      post work_experiences_url, params: { work_experience: {  } }
    end

    assert_redirected_to work_experience_url(WorkExperience.last)
  end

  test "should show work_experience" do
    get work_experience_url(@work_experience)
    assert_response :success
  end

  test "should get edit" do
    get edit_work_experience_url(@work_experience)
    assert_response :success
  end

  test "should update work_experience" do
    patch work_experience_url(@work_experience), params: { work_experience: {  } }
    assert_redirected_to work_experience_url(@work_experience)
  end

  test "should destroy work_experience" do
    assert_difference("WorkExperience.count", -1) do
      delete work_experience_url(@work_experience)
    end

    assert_redirected_to work_experiences_url
  end
end
