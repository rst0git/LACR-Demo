class SearchController < ApplicationController
    def search
      if params[:q].nil?
        @documents = []
      else
        Document.reindex
        @documents = Document.search( params[:q], suggest: true, match: :phrase)
      end
    end
end
