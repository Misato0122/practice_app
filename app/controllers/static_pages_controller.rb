class StaticPagesController < ApplicationController
=begin
  before_action :logged_inを使ってしまうとサインアップしていないユーザー全てが
  ログインできなくなってしまうので使わない。
=end

  def home
    if logged_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
