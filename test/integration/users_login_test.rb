require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @gai = users(:gai)
  end

  # test process
  # 1. Visit the login path.
  # 2. Verify that the login/session form renders correctly.
  # 3. Post to the sessions path with an invalid email and password.
  # 4. Verify that the login/session form renders again and verify flash messages appear.
  # 5. Visit another page (such as the Home page).
  # 6. Verify that the flash message disappears on the new page.
  test "login with invalid information" do
    get login_path #1
    assert_template "sessions/new" #2
    post login_path, session: { email: "wrong", password: "login_info"}  #3
    assert_template "sessions/new"  #4
    assert_not flash.empty? # test only pass if flash.empty is false. # 4
    get root_path #get "/" #5
    assert flash.empty?  #6, must be empty in the new page
  end

  # login w/ valid info process
  # 1. visit login path
  # 2. post to the session path with valid email + password
  # 2.5. verify the user is logged in
  # 3. verify after login, it redirects to the user path (.../users/1)
  # 4. verify the sign up link disappears
  # 5. verify the login link disappears
  # 6. verify the home link appears
  # 7. verify the profile link appears
  # 8. verify the setting link appears (not active yet)
  # 9. verify the logout link appears
  # add logout after login
  # 10. make a delete request to the log out path
  # 11. verify the user is NOT logged_in?
  # 12. verify the page is redirected to the root page
  # 12.5 delete request to log out path again (prevent multiple tabs error. Only logout if only user is logged in)
  # 13. verify the sign up link appears
  # 14. verify the login link appears
  # 15. verify the home link appears on the paper trading logo
  # 16. verify the logout link disappearts
  # 17. verify the profile link disappears
  test "login with valid information and then logout" do
    get login_path  #1
    post login_path, session: { email: @gai.email, password: "123456"}  #2
    assert user_logged_in? # 2.5
    assert_redirected_to @gai #3
    follow_redirect!  # visit target page
    assert_template "users/show"
    assert_select "a[href=?]", signup_path, count: 0  #4
    assert_select "a[href=?]", login_path, count: 0 #5
    assert_select "a[href=?]", root_path, count: 2 #6
    assert_select "a[href=?]", user_path(@gai)   #7
    # assert_select "a[href=?]", edit_user_path(@gai)   #8
    assert_select "a[href=?]", logout_path   #9

    # add logout test after login
    delete logout_path  #10
    assert_not user_logged_in? # 11, user_logged_in? returns false to pass
    assert_redirected_to root_url  # 12
    # 12.5 simulate a browser w/ multiple tabs, one tab is logged out, the second tab attempts to log out
    # should not give us an error
    delete logout_path  #12.5
    follow_redirect! # visit the target (root) page
    assert_select "a[href=?]", signup_path, count: 1      #13
    assert_select "a[href=?]", login_path, count: 1       #14
    assert_select "a[href=?]", root_path, count: 1        #15
    assert_select "a[href=?]", logout_path, count: 0      #16
    assert_select "a[href=?]", user_path(@gai), count: 0   #17
  end

  # testing remember me feature flow
  # 1. log in user
  # 2. verify the remember_token is not nil
  # (since a remember_digest is created if the user login w/ the remember me box is checked)
  # 3. verify the remember_token in cookies is same as remember_token created by the user
  test "remember me feature when remember me box is checked" do
    log_in_as(@gai, { remember_me: "1" })
    assert_not(cookies["remember_token"].nil?)
    #assigns method allows us to access the instance variable @user and its virtual attribute (e.g. remember_token)
    assert_equal(cookies["remember_token"], assigns(:user).remember_token)
  end

  # testing remember me feature flow
  # log in user
  # verify the remember_digest is nil
  test "remember me feature when remember me box is unchecked" do
    log_in_as(@gai, remember_me: "0")
    assert_equal(cookies[:remember_token], nil) # assert_nil also works!
  end
end
