require "test_helper"

class HealthcheckControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get healthcheck_index_url
    assert_response :success
  end
end
