require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
	def setup
		@user = users(:julie)
	end

	test "unsuccessful edit" do
		log_in_as(@user)
		get edit_user_path(@user)
		assert_template 'users/edit'
		patch user_path(@user), user: { name: "",
										email: "foo@invalid",
										username: "",
										password: "foo",
										password_confirmation: "bar"}

		assert_template 'users/edit'
	end

	test "successful edit" do
		log_in_as(@user)
		get edit_user_path(@user)
		assert_template 'users/edit'
		name = "Foo Bar"
		username = "foobar"
		email = "foo@bar.com"
		patch user_path(@user), user: { name: name,
										email: email,
										username: username,
										password: "",
										password_confirmation: "" }
		assert_not flash.empty?
		assert_redirected_to @user
		@user.reload
		assert_equal @user.name, name
		assert_equal @user.email, email
		assert_equal @user.username, username
	end

	test "successful edit with friendly forwarding" do 
		get edit_user_path(@user)
		log_in_as(@user)
		assert_redirected_to edit_user_path(@user)
		name = "Foo Bar"
		username = "foobar"
		email = "foo@bar.com"
		patch user_path(@user), user: { name: name,
										email: email,
										username: username,
										password: "",
										password_confirmation: "" }
		assert_not flash.empty?
		assert_redirected_to @user
		@user.reload
		assert_equal @user.name, name
		assert_equal @user.email, email
		assert_equal @user.username, username
	end
end
