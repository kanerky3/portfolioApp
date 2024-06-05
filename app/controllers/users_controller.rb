class UsersController < ApplicationController
  # ログインできていない場合
  before_action :authenticate_user, {only: [:index, :show, :edit, :update]}
  # ログインできている場合
  before_action :forbid_login_user, {only: [:new, :create, :login_form, :login]}
  before_action :ensure_correct_user, {only: [:edit, :update]}
  
  def index
    # ユーザー一覧
    @users = User.all
  end
  
  def show
    # ユーザー詳細
    @user = User.find_by(id: params[:id])
  end
  
  def new
    # ユーザー新規作成
    @user = User.new
  end

  def create
    # ユーザー新規作成処理
    @user = User.new(
      name: params[:name],
      email: params[:email],
      image_name: "standard.png",
      password: params[:password]
    )
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/new")
    end
  end

  def edit
    # ユーザー編集
    @user = User.find_by(id: params[:id])
  end

  def update
    # ユーザー編集アクション
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    
    if params[:image]
      # ファイルがない場合、自動で生成する
      FileUtils.mkdir_p('public/user_images') unless Dir.exist?('public/user_images')
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("public/user_images/#{@user.image_name}", image.read)
    end
    
    if @user.save
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end
  end

  def login_form
  end

  def login
    # ログイン処理
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to("/")
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render("users/login_form")
    end
  end

  def logout
    # ログアウト処理
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login")
  end

  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end

end
