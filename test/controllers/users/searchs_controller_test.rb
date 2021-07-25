require 'test_helper'

class Users::SearchsControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get users_searchs_search_url
    assert_response :success
  end

end
