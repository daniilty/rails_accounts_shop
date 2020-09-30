require 'test_helper'

class AccountControllerTest < ActionDispatch::IntegrationTest
  test "should get buy" do
    get account_buy_url
    assert_response :success
  end

end
