class SearchController < ApplicationController
  def search
    if Search.count.zero? # Fix search on empty table error msg
      redirect_to doc_path
    end
    # Use strong params
    permited = simple_search_params

    # Parse Spelling variants and Results per page
    get_search_tools_params(permited)

    # Parse order_by parameter
    order_by = get_order_by(permited)

    # Send the query to Elasticsearch
    @documents = Search.search @query,
        fields: ['content'],
        suggest: true,
        match: :word_start,
        page: permited[:page], per_page: @results_per_page,
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
       misspellings: {prefix_length: 2, edit_distance: 2,below: 4}
     }).map(&:highlighted_content).uniq
   end

  def autocomplete_entry
     render json: Search.search(params[:q], {
       fields: ['entry'],
       match: :word_start,
       limit: 10,
       load: false,
       misspellings: {below: 5}
     }).map(&:entry)
   end

  def advanced_search
    if Search.count.zero? # Fix search on empty table error msg
      redirect_to doc_path
    end

    # Use strong params
    permited = simple_search_params

    # Parse Spelling variants and Results per page
    get_search_tools_params(permited)

    # Parse order_by parameter
    order_by = get_order_by(permited)

    # Use wildcard when no content was specified
    @query = permited[:q].present? ? permited[:q] : '*'

    where_query = {}
    if permited[:entry] # Filter by Entry ID
      where_query['entry'] = Regexp.new "#{permited[:entry]}.*"
    end
    if permited[:date_from] # Filter by lower date bound
      begin
        # Get date and calc length
        date_str = permited[:date_from]
        date_str_length = date_str.split('-').length
        # Fix incorrect date format
        if date_str_length == 3
          where_query['date'] = {'gte':  date_str.to_date }
        elsif date_str_length == 2
          where_query['date'] = {'gte': "#{date_str}-1".to_date }
        elsif date_str_length == 1
          where_query['date'] = {'gte': "#{date_str}-1-1".to_date }
        end
      rescue
        flash[:notice] = "Incorrect \"Date from\" format"
      end
    end
    if permited[:date_to] # Filter by upper date bound
      begin
        # Get date and calc length
        date_str = permited[:date_to]
        date_str_length = date_str.split('-').length
        # Fix incorrect date format
        if date_str_length == 3
          where_query['date'] = {'lte': date_str.to_date }
        elsif date_str_length == 2
          where_query['date'] = {'lte': "#{date_str}-28".to_date }
        elsif date_str_length == 1
          where_query['date'] = {'lte': "#{date_str}-12-31".to_date}
        end
      rescue
        flash[:notice] = "Incorrect \"Date to\" format"
      end
    end
    if permited[:lang] # Filter by language
      where_query['lang'] = permited[:lang]
    end
    if permited[:v] # Filter by voume
      where_query['volume'] = permited[:v].split(/,| /).map { |s| s.to_i }
    end
    if permited[:pg] # Filter by page
      where_query['page'] = permited[:pg].split(/,| /).map { |s| s.to_i }
    end
    if permited[:pr] # Filter by paragraph
      where_query['paragraph'] = permited[:pr].split(/,| /).map { |s| s.to_i }
    end

    @documents = Search.search @query,
      where: where_query,
      fields: [:content],
      highlight: {tag: "<mark>"},
      suggest: true,
      load: false,
      page: permited[:page], per_page: @results_per_page,
      order: order_by,
      misspellings: {edit_distance: @misspellings}

    render :search
  end # def advanced_search

  private

  def simple_search_params
    params.permit(:q, :r, :m, :o, :entry, :date_from, :date_to, :v, :pg, :pr, :lang, :page)
  end

  def get_search_tools_params(permited)

    # Get text from the user input. In case of empty search -> use '*'
    @query = permited[:q].present? ? permited[:q] : '*'

    # Get the number of results per page; Default value -> 5
    @results_per_page = 5
    results_per_page = permited[:r].to_i
    if results_per_page >= 5 and results_per_page <= 50
      @results_per_page = results_per_page
    end

    # Get the misspelling distance; Default value -> 2
    @misspellings = 2
    misspellings = permited[:m].to_i
    if misspellings >= 0 and misspellings <= 5
      @misspellings = misspellings
    end
  end

  def get_order_by(permited)
    # Get the orderBy mode
    # 0 -> Most relevant first
    # 1 -> Volume/Page in ascending order
    # 2 -> Volume/Page in descending order
    # 3 -> Chronological orther
    @orderBy = permited[:o].to_i
    order_by = {}
    if @orderBy == 0
      order_by['_score'] = :desc # most relevant first - default
    elsif @orderBy == 1
      order_by['volume'] = :asc # volume ascending order
      order_by['page'] = :asc # page ascending order
    elsif @orderBy == 2
      order_by['volume'] = :desc # volume descending order
      order_by['page'] = :desc # page descending order
    elsif @orderBy == 3
      order_by['date'] = :asc
    end
    return order_by
  end
end
