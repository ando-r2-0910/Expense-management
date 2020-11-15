class Users::ImageInitializationsController < ApplicationController
  before_action :find_user, only: :update
  before_action :logged_in_user, only: :update
  before_action :correct_user_for_child_controller, only: :update

  def update
    @user.img = "default_img.png"
    @user.header_image = "default_header_image.png"
    if @user.save
      flash[:success] = "画像を初期画像へ戻しました。"
      redirect_to(edit_user_images_path(@user))
    else
      flash.now[:danger] = "エラーが発生しました。時間をおいてもう一度実行してみてください。"
      render("users/images#edit")
    end
  end
end
