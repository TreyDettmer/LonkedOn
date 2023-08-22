require "application_system_test_case"

class WorkExperiencesTest < ApplicationSystemTestCase
  setup do
    @work_experience = work_experiences(:one)
  end

  test "visiting the index" do
    visit work_experiences_url
    assert_selector "h1", text: "Work experiences"
  end

  test "should create work experience" do
    visit work_experiences_url
    click_on "New work experience"

    click_on "Create Work experience"

    assert_text "Work experience was successfully created"
    click_on "Back"
  end

  test "should update Work experience" do
    visit work_experience_url(@work_experience)
    click_on "Edit this work experience", match: :first

    click_on "Update Work experience"

    assert_text "Work experience was successfully updated"
    click_on "Back"
  end

  test "should destroy Work experience" do
    visit work_experience_url(@work_experience)
    click_on "Destroy this work experience", match: :first

    assert_text "Work experience was successfully destroyed"
  end
end
