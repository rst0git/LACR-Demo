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

      @orderBy = params[:o].to_i
      order_by = {}
      if params[:o]
        if @orderBy == 0
          order_by['_score'] = :desc # most relevant first - default
        elsif @orderBy == 1
          order_by['volume'] = :asc # volume ascending order
          order_by['page'] = :asc # page ascending order
        end
      end

      @documents = Search.search @query,
          fields: ['content'],
          suggest: true,
          match: :word_start,
          page: params[:page], per_page: @results_per_page,
          highlight: {tag: "<mark>"},
          load: false,
          order: order_by,
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
    if Search.count.zero? # Fix search on empty table error msg
      redirect_to doc_path
    end

    if params[:q].present? # Searching
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

      where_query = {}

      if params[:entry]
        where_query['entry'] = params[:entry]
      end

      if params[:date_from]
        where_query['date'] = {'gte': params[:date_from]}
      end

      if params[:date_to]
        where_query['date'] = {'lte': params[:date_to]}
      end

      if params[:lang]
        where_query['lang'] = params[:lang]
      end

      if params[:v]
        where_query['volume'] = params[:v].split(/,| /).map { |s| s.to_i }
      end
      if params[:pg]
        where_query['page'] = params[:pg].split(/,| /).map { |s| s.to_i }
      end
      if params[:pr]
        where_query['paragraph'] = params[:pr].split(/,| /).map { |s| s.to_i }
      end

      @documents = Search.search @query,
      where: where_query,
      fields: [:content],
      highlight: {tag: "<mark>"},
      suggest: true,
      load: false,
      page: params[:page], per_page: @results_per_page,
      misspellings: {edit_distance: @misspellings}

      render :search
    end # if params[:q].present?
  end # def advanced_search

end
