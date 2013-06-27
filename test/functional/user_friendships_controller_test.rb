require 'test_helper'

class UserFriendshipsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  context "#new" do
  	context "when not logged in" do
  		should "redirect to the login page" do
  			get :new
  			assert_response :redirect
  		end
  	end
  end

  context "when logged in" do
  	setup do
  		sign_in users(:kevin)
  	end

  	should "get new and return success" do
  		get :new
  		assert_response :success
  	end

  	should "should set a flash error is the friend_id params is missing" do
  		get :new, {}
  		assert_equal "Friend required", flash[:error]
  	end

  	should "display the friend's name" do
  		get :new, friend_id: users(:alec).id
  		assert_match /#{users(:alec).full_name}/, response.body
  	end

  	should "assign a new user friendship" do
  		get :new, friend_id: users(:alec).id
  		assert assigns(:user_friendship)
  	end

  	should "assign a new user friendship to the correct friend" do
  		get :new, friend_id: users(:alec).id
  		assert_equal users(:alec), assigns(:user_friendship).friend
  	end

  	should "assign a new user friendship to the currently logged in user" do
  		get :new, friend_id: users(:alec).id
  		assert_equal users(:kevin), assigns(:user_friendship).user
  	end

  	should "return a 404 status if no friend is found" do
  		get :new, friend_id: 'invalid'
  		assert_response :not_found
  	end
  end

end
