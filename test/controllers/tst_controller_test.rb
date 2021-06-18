require "test_helper"

class TstControllerTest < ActionDispatch::IntegrationTest
  test "should get retour" do
    get tst_retour_url
    assert_response :success
  end
end
