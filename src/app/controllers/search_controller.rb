class SearchController < ApplicationController
    def search
      if params[:q].nil?
        @articles = []
      else
        Article.reindex
        @articles = Article.search( params[:q], suggest: true, match: :phrase)
      end
    end
end
