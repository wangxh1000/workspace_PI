require 'test_helper'

class TeamControllerTest < ActionController::TestCase
  test "should get team" do
    get :team
    assert_response :success
  end

end
