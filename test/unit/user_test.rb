require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  should have_many(:user_friendships)
  should have_many(:friends)

  test "a user should enter a first name" do
  	user = User.new
  	assert !user.save
  	assert !user.errors[:first_name].empty?
  end

  test "a user should enter a last name" do
  	user = User.new
  	assert !user.save
  	assert !user.errors[:last_name].empty?
  end

  test "a user should enter a profile name" do
  	user = User.new
  	assert !user.save
  	assert !user.errors[:profile_name].empty?
  end

  test "a user should have a unique profile name" do
  	user = User.new
  	user.profile_name = users(:kevin).profile_name

  	assert !user.save
  	assert !user.errors[:profile_name].empty?
  end

  test "a user should have a profile name without spaces" do
  	user = User.new(first_name: 'Kevin', last_name: 'Lehtiniitty', email: 'kevin2@tinitt.com')
    user.password = user.password_confirmation = 'asdfasf'

  	user.profile_name = "My Profile With Spaces"

  	assert !user.save
  	assert !user.errors[:profile_name].empty?
  	assert user.errors[:profile_name].include?("must be formatted correctly.")
  end

  test "a user can have a correctly formatted profile name" do
    user = User.new(first_name: 'Kevin', last_name: 'Lehtiniitty', email: 'kevin1234@tinitt.com')
    user.password = user.password_confirmation = 'asdfasf123'

    user.profile_name = "kevin_l_2"
    assert user.valid?
  end

  test "no error is reaised trying to access a friend list" do
    assert_nothing_raised do
      users(:kevin).friends
    end
  end

  test "that creating friendships on a user works" do
    users(:kevin).friends << users(:mike)
    users(:kevin).friends.reload
    assert users(:kevin).friends.include?(users(:mike))
  end

  test "that creating a friendship based on user id and friend id works" do
    UserFriendship.create user_id: users(:kevin).id, friend_id: users(:mike).id
    assert users(:kevin).friends.include?(users(:mike))
  end
end
