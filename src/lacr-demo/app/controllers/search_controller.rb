class SearchController < ApplicationController
  def search
    if Search.count.zero? # Fix search on empty table error msg
      redirect_to doc_path
    else
      @query = params[:q].present? ? params[:q] : '*'
      @documents = Search.search @query,
          suggest: true,
          match: :word_start,
          page: params[:page], per_page: 6,
          highlight: {tag: "<mark>"},
          load: false,
          misspellings: {prefix_length: 2}
    end
  end

  def autocomplete
     render json: Search.search(params[:q], {
       fields: ['content'],
       match: :word_start,
       highlight: {tag: "" ,fields: {content: {fragment_size: 0}}},
       limit: 10,
       load: false,
       misspellings: {prefix_length: 2}
     }).map(&:highlighted_content).uniq
   end


  def advanced_search
  end

  def filter
    if Search.count.zero? # Fix search on empty table error msg
      redirect_to doc_path
    else
      @query = params[:q].present? ? params[:q] : '*'
      @documents = Search.search @query, suggest: true
    end
    render :search
  end
end
