require 'test_helper'
class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title, "Divelog"
    assert_equal full_title("Help"), "Help | #{full_title()}"
  end
end
