class SearchController < ApplicationController
  def search
    if Search.count.zero? # Fix search on empty table error msg
      redirect_to doc_path
    end
      @query = params[:q].present? ? params[:q] : '*'

      if params[:r].present?
        if params[:r].to_i >= 5 and params[:r].to_i <= 50
          @results_per_page = params[:r].to_i
        else
          @results_per_page = 5
        end
      else
        @results_per_page = 5
      end

      if params[:m].present?
        if params[:m].to_i >= 0 and params[:m].to_i <= 5
          @misspellings = params[:m].to_i
        else
          @misspellings = 2
        end
      else
        @misspellings = 2
      end

      @documents = Search.search @query,
          fields: ['content'],
          suggest: true,
          match: :word_start,
          page: params[:page], per_page: @results_per_page,
          highlight: {tag: "<mark>"},
          load: false,
          misspellings: {edit_distance: @misspellings}
  end

  def autocomplete
     render json: Search.search(params[:q], {
       fields: ['content'],
       match: :word_start,
       highlight: {tag: "" ,fields: {content: {fragment_size: 0}}},
       limit: 10,
       load: false,
       misspellings: {prefix_length: 2, edit_distance: 2}
     }).map(&:highlighted_content).uniq
   end


  def advanced_search
  end

  def filter
    if Search.count.zero? # Fix search on empty table error msg
      redirect_to doc_path
    end
    @content_all = params[:content_all].present? ? params[:content_all].split(' ') : ''
    @content_any = params[:content_any].present? ? params[:content_any].split(' ') : ''
    @content_none = params[:content_none].present? ? params[:content_none].split(' ') : ''
    @documents = Search.search @query,
        suggest: true,
        match: :word_start,
        page: params[:page], per_page: 6,
        highlight: {tag: "<mark>"},
        load: false,
        misspellings: {prefix_length: 2},
        where: {
          content: @content_any,
          content: {all: @content_all},
          content: {not: @content_none}
        }
    render :search
  end
end
