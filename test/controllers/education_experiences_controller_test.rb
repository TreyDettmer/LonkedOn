require "test_helper"

class EducationExperiencesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @education_experience = education_experiences(:one)
  end

  test "should get index" do
    get education_experiences_url
    assert_response :success
  end

  test "should get new" do
    get new_education_experience_url
    assert_response :success
  end

  test "should create education_experience" do
    assert_difference("EducationExperience.count") do
      post education_experiences_url, params: { education_experience: {  } }
    end

    assert_redirected_to education_experience_url(EducationExperience.last)
  end

  test "should show education_experience" do
    get education_experience_url(@education_experience)
    assert_response :success
  end

  test "should get edit" do
    get edit_education_experience_url(@education_experience)
    assert_response :success
  end

  test "should update education_experience" do
    patch education_experience_url(@education_experience), params: { education_experience: {  } }
    assert_redirected_to education_experience_url(@education_experience)
  end

  test "should destroy education_experience" do
    assert_difference("EducationExperience.count", -1) do
      delete education_experience_url(@education_experience)
    end

    assert_redirected_to education_experiences_url
  end
end
