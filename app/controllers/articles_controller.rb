class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]

  # GET /articles or /articles.json
def index
  if current_user
    @user_articles = current_user.articles.order(created_at: :desc)
    @other_articles = Article.where.not(user_id: current_user.id).order(created_at: :desc)
    @articles = @user_articles + @other_articles
  else
    @articles = Article.all.order(created_at: :desc)
  end
end



  # GET /articles/1 or /articles/1.json
  def show
    @article = Article.find(params[:id])
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles or /articles.json
def create
  @article = current_user.articles.build(article_params)

  respond_to do |format|
    if @article.valid?
      @article.save
      format.html { redirect_to article_url(@article), notice: "Articulo creado satisfactoriamente" }
      format.json { render :show, status: :created, location: @article }
    else
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: @article.errors, status: :unprocessable_entity }
    end
  end
end


  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    respond_to do |format|
      if current_user.id == @article.user_id # Verifica si el usuario actual es el propietario del artículo
        if @article.update(article_params)
          format.html { redirect_to article_url(@article), notice: "Articulo Actualizado satisfactoriamente" }
          format.json { render :show, status: :ok, location: @article }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @article.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to article_url(@article), alert: "You are not authorized to edit this article." }
        format.json { render json: { error: "You are not authorized to edit this article." }, status: :unauthorized }
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url, notice: "Articulo Eliminado satisfactoriamente" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
    params.require(:article).permit(:title, :content, :user_id, :name)
    end
end
