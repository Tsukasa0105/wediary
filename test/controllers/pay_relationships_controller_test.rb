require 'test_helper'

class PayRelationshipsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get pay_relationships_create_url
    assert_response :success
  end

  test "should get destroy" do
    get pay_relationships_destroy_url
    assert_response :success
  end

end
