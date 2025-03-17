require "test_helper"

class ScopesControllerTest < ActionDispatch::IntegrationTest
  test "should get archive_licenses" do
    get scopes_archive_licenses_url
    assert_response :success
  end
end
