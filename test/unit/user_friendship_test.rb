require 'test_helper'

class UserFriendshipTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  should belong_to(:user)
  should belong_to(:friend)

  test "that creating a friendship works without raising an exception" do
  	assert_nothing_raised do
  		UserFriendship.create user: users(:kevin), friend: users(:mike)
  	end
  end
end
