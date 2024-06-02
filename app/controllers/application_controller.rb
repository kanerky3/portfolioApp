class ApplicationController < ActionController::Base
    # @current_user有効化
    before_action :set_current_user

    # ログイン情報を@current_userへ
    def set_current_user
        @current_user = User.find_by(id: session[:user_id])
    end
    
    # ログインできていない場合
    def authenicate_user
        if @current_user == nil
            flash[:notice] = "ログインが必要です。"
            redirect_to("/login")
        end
    end

    # ログインできている場合
    def forbid_login_user
        if @current_user
            flash[:notice] = "すでにログインしています"
            redirect_to("/posts/index")
        end
    end
end
