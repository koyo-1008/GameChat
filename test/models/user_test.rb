require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                 nickname: "koyo", password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "ユーザーネームが入力されてない時データベースに登録されてないか " do
    @user.name = "     "
    assert_not @user.valid?
  end

  test "ニックネームが入力されてない時データベースに登録されてないか " do
    @user.nickname = "     "
    assert_not @user.valid?
  end
  test "メールアドレスが入力されてない時データベースに登録されてないか " do 
    @user.email = "    "
    assert_not @user.valid?
  end

  test "ユーザーネームが50文字以上の場合データベースに登録されてないか" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "メールアドレスが255文字以上は登録できないか" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "有効なメールアドレスが認証されるか" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "無効なメールアドレスが承認されないか" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "メールアドレスの重複が起きてないか" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "メールアドレスが小文字で登録されてるか" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "空のパスワードは登録されないか" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "6文字以下のパスワードは登録されないか" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
end