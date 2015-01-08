require 'test_helper'

class OneTestControllerTest < ActionController::TestCase
  test "should get one_test" do
    get :one_test
    assert_response :success
  end

end
