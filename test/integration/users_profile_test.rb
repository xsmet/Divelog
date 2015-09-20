  require 'test_helper'
  require 'rails_autolink'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper # for the full_title helper we defined

  def setup
    @user = users(:xavier)
  end

  test "profile display" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_select 'h1', text: @user.name
    assert_select 'h1>img.gravatar'
    assert_match @user.microposts.count.to_s, response.body
    assert_select 'div.pagination'
    @user.microposts.paginate(page: 1).each do |micropost|
      # Because links will be rendered to html, micropost content will differ
      # TODO user the render_links helper instead of skipping the post
      assert_match micropost.content, response.body unless micropost.content.include?('http')
    end
  end
end
