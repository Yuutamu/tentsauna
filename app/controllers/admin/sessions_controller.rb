# frozen_string_literal: true

class Admin::SessionsController < Devise::SessionsController
  protected

  # MEMO:メソッドにてadmin ログイン後にリダイレクトされるページを指定
  # MEMO：after_sign_in_path_for はdevice が用意しているメッド
  def after_sign_in_path_for(_resource)
    admin_root_path
  end
end
