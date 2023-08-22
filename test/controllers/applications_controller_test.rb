require "test_helper"

class ApplicationsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get applications_create_url
    assert_response :success
  end

  test "should get destroy" do
    get applications_destroy_url
    assert_response :success
  end

  test "should get application_params" do
    get applications_application_params_url
    assert_response :success
  end
end
