class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: [:destroy]

=begin
  static_pagesのviewであるhomeページでは@feed_itemsを求めているが、micropostの作成に失敗すると
  @feed_itemsの値がnilになってしまうためエラーが起きる。
  そのため必要な@feed_itemsの値をelse側で渡しておく必要がある。
  homeアクションを使用していないためhomeアクションには書かない。
=end
  def create
    @micropost = current_user.microposts.build(micropost_params)
    # @micropost.image.attach(params[:micropost][:image])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'static_pages/home'
    end
  end

=begin
  request.referrerはどこからリクエストが送られてきたかの情報が入っている。
  referrerの情報が入っていればそのリクエストにアクセスし、nilであれば
  rootパスにアクセスする。
=end
  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end

private

  def micropost_params
    params.require(:micropost).permit(:content, :image)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: [params[:id]])
    redirect_to root_url if @micropost.nil?
  end
end
