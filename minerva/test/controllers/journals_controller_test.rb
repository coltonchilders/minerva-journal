require 'test_helper'

class JournalsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get journals_index_url
    assert_response :success
  end

end
