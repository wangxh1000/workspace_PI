require 'test_helper'

class SandboxControllerTest < ActionController::TestCase
  test "should get sandbox" do
    get :sandbox
    assert_response :success
  end

end
