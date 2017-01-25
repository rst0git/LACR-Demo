class SearchController < ApplicationController
    def search

      if Search.count.zero? # Fix search on empty table error msg
        redirect_to doc_path
      else

        Search.reindex
        @documents = Search.search( params[:q].present? ? params[:q] : '*',

          order: [{published_at: {order: "desc", ignore_unmapped: :long}}],
          fields: [:title, :content],
          suggest: true, match: :phrase,
          page: params[:page],
          per_page: 8)
        end
        
    end
end
