require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase
  test "should get show" do
    get :show, id: users(:kevin).profile_name
    assert_response :success
    assert_template 'profiles/show'
  end

  test "no profile renders 404 page" do
  	get :show, id: "doesn't exist"
  	assert_response :not_found
  end

  test "that variables are assigned on successful profile viewing" do
  	get :show, id: users(:kevin).profile_name
  	assert assigns(:user)
  	assert_not_empty assigns(:statuses)
  end

  test "only correct statuses shown for user" do
  	get :show, id: users(:kevin).profile_name
  	assigns(:statuses).each do |status|
  		assert_equal users(:kevin), status.user
  	end
  end

end
