class DocumentsController < ApplicationController
    def index
        @articles = Articles.all
    end

    def show
      @article = Articles.find params[:id]
    end
    
    def example
    end	

    def new
    end
    
    def create
      @article = Articles.new article_params
      if @article.save
        redirect_to @article
      else
        render 'new'
      end
    end
    
    private
      def article_params
        params.require(:documents).permit :title, :data
      end
end
