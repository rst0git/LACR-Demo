class DocumentsController < ApplicationController
  def index
    @documents = Document.all
  end

  def show
    @document = Document.find params[:id]
  end

  # def edit
  #   @document = Document.find(params[:id])
  #
  # end

  def new
    @upload = Upload.new
  end

  # def save
  #   @document = Document.new document_params
  #   if @document.save
  #     redirect_to @document, notice: "The document #{@document.title} has been made available."
  #   else
  #     render 'edit'
  #   end
  # end

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
      title = @document.title
      @document.destroy
      redirect_to doc_path, notice:  "The document #{title} has been removed."
   end

  private
    def upload_params
      params.require(:upload).permit :xml, :image
    end

  # private
  #   def document_params
  #     params.require(:document).permit :title, :content
  #   end
end
