require 'test_helper'

class InstitutesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get institutes_new_url
    assert_response :success
  end

  test "should get edit" do
    get institutes_edit_url
    assert_response :success
  end

  test "should get show" do
    get institutes_show_url
    assert_response :success
  end

  test "should get index" do
    get institutes_index_url
    assert_response :success
  end

end
