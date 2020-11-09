require 'test_helper'

class GroupUserPermissionsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get group_user_permissions_create_url
    assert_response :success
  end

  test "should get destroy" do
    get group_user_permissions_destroy_url
    assert_response :success
  end

end
