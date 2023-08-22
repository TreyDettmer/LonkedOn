require "application_system_test_case"

class EducationExperiencesTest < ApplicationSystemTestCase
  setup do
    @education_experience = education_experiences(:one)
  end

  test "visiting the index" do
    visit education_experiences_url
    assert_selector "h1", text: "Education experiences"
  end

  test "should create education experience" do
    visit education_experiences_url
    click_on "New education experience"

    click_on "Create Education experience"

    assert_text "Education experience was successfully created"
    click_on "Back"
  end

  test "should update Education experience" do
    visit education_experience_url(@education_experience)
    click_on "Edit this education experience", match: :first

    click_on "Update Education experience"

    assert_text "Education experience was successfully updated"
    click_on "Back"
  end

  test "should destroy Education experience" do
    visit education_experience_url(@education_experience)
    click_on "Destroy this education experience", match: :first

    assert_text "Education experience was successfully destroyed"
  end
end
