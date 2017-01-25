class DocumentsController < ApplicationController
  def index
    @documents = Document.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    if params.has_key?(:id)
      @document = Document.find params[:id]
    else
      redirect_to doc_path, notice:  "The document has not been found."
    end
  end

  def new
    @upload = Upload.new
  end

  def upload
    @upload = Upload.new upload_params

    if @upload.save
      redirect_to doc_path, notice: "The files have been uploaded succesfully."
    else
      render 'new'
    end
  end

  def destroy
      @document = Document.find(params[:id])
      @search = Search.find(params[:id])
      title = @document.title
      @document.destroy
      @search.destroy
      redirect_to doc_path, notice:  "The document #{title} has been removed."
   end

  private
    def upload_params
      params.require(:upload).permit :xml, :image
    end
end
