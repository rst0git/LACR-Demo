class SearchController < ApplicationController
    def search

      if Search.count.zero? # Fix search on empty table error msg
        redirect_to doc_path
      else
        Search.reindex
        @documents = Search.search( params[:q].present? ? params[:q] : '*',
          fields: [:title, :content],
          highlight: {fields: {content: {fragment_size: 100}}},
          suggest: true,
          match: :phrase,
          page: params[:page],
          misspellings: {below: 1},
          per_page: 6)
        end

    end

    def autocomplete
      render json: Search.search(params[:query], {
        fields: [:title],
        match: :word_start,
        limit: 10,
        load: false
        # misspellings: {below: 2}
      }).map(&:title)
    end
end
