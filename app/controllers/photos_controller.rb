class PhotosController < ApplicationController
  def index
    # 投稿一覧
    @photos = Photo.all.order(created_at: :desc)
  end

  def about
    # アプリについて
  end


  def new
    # 新規作成
    @photo = Photo.new
  end

  def show
    @photo = Photo.find_by(id: params[:id])
  end

  def create
    # 投稿新規作成
    @photo = Photo.new
    @photo.user_id = @current_user.id
    @photo.content = params[:content]
    # @photo.save

    if params[:image]
      flash[:notice] = "画像を受け取り"
      # public/photos ディレクトリが存在するか確認し、存在しない場合は作成
      FileUtils.mkdir_p('public/photos') unless Dir.exist?('public/photos')
      
      image = params[:image]
      # 一意のファイル名を生成（UUID）
      image_name = SecureRandom.uuid + File.extname(image.original_filename)
      @photo.image_name = image_name
      
      # 画像ファイルを保存
      File.binwrite("public/photos/#{image_name}", image.read)
    end
    
    if @photo.save
      flash[:notice] = "投稿を作成しました"
      redirect_to("/photos/index")
    else
      render("photos/new")
    end
  end

  def edit
    @photo = Photo.find_by(id: params[:id])
  end

  def update
    @photo = Photo.find_by(id: params[:id])
    @photo.content = params[:content]
    if params[:image]
      FileUtils.mkdir_p('public/photos') unless Dir.exist?('public/photos')
      image = params[:image]
      # 一意のファイル名を生成（UUID）
      image_name = SecureRandom.uuid + File.extname(image.original_filename)
      @photo.image_name = image_name
      File.binwrite("public/photos/#{image_name}", image.read)
    end
    if @photo.save
      flash[:notice] = "投稿を編集しました"
      redirect_to("/photos/#{@photo.id}")
    else
      render("photo/edit")
    end
  end

  def destroy
    # 削除メソッド
    @photo = Photo.find_by(id: params[:id])
    @photo.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to("/photos/index")
  end

end
