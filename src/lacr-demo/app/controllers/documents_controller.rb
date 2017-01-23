class DocumentsController < ApplicationController
  def index
    @documents = Document.all
  end

  def show
    @document = Document.find params[:id]
  end

  def edit
  end

  def new
  end

  def create
    @document = Document.new document_params
    if @document.save
      redirect_to @document
    else
      render 'new'
    end
  end

  private
    def document_params
      params.require(:document).permit :title, :content
    end
end
