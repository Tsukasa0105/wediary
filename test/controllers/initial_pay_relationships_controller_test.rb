require 'test_helper'

class InitialPayRelationshipsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get initial_pay_relationships_create_url
    assert_response :success
  end

  test "should get destroy" do
    get initial_pay_relationships_destroy_url
    assert_response :success
  end

end
