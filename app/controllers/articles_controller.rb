class ArticlesController < ApplicationController
  
  http_basic_authenticate_with(
    name: ENV["BASIC_AUTH_NAME"],
    password: ENV["BASIC_AUTH_PASS"],
    except: [:index, :show])

  def search
    if params[:query].blank?
     redirect_to articles_path
    else      
      substr = params[:query].downcase
      @articles = Article.where 'LOWER(title) LIKE ?', "%#{substr}%"
    end
  end

  # index, show, new, edit, create, update, destroy
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    # This is needed because @article would be nil when the view is first loaded,
    # and calling @article.errors.any? would throw an error (instead of false).
    # When you render :new in the create action there is no problem
    # because it's using the @article defined at the top of create
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end  

  def create
    # render plain: params[:article].inspect
    @article = Article.new(article_params)
   
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])
   
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
   
    redirect_to articles_path
  end
   
  private
    def article_params
      params.require(:article).permit(:title, :text)
    end
end
