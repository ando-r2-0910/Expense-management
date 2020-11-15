class Users::ImagesController < ApplicationController
  before_action :find_user, only: %i[edit update]
  before_action :logged_in_user, only: %i[edit update]
  before_action :correct_user_for_child_controller, only: %i[edit update]

  def edit
    @settings_class = ""
    @images_class = "active"
    @category_class = ""
  end

  def update
    if @user.update_attributes(user_images_params)
      flash[:success] = "画像を更新しました。"
      redirect_to(edit_user_images_path(@user))
    else
      flash.now[:danger] = "エラーが発生しました。時間をおいてもう一度実行してみてください。"
      render("users/images#edit")
    end
  end
end
