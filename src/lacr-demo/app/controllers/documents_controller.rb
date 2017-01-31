class DocumentsController < ApplicationController
  def index
    # @pages = PageImage.paginate(:page => params[:page], :per_page => 10)
    @documents = TranscriptionJsonParagraph.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    if params.has_key?(:id)
      @document = TranscriptionJsonParagraph.find params[:id]
    else
      redirect_to doc_path, notice:  "The document has not been found."
    end
  end

  def new
    @document = PageImage.new
    @document.transcription_xml = TranscriptionXml.new
  end

  def upload
    # @document = PageImage.new(image_params).create_transcription_xml(xml_params)
    @document = PageImage.new(document_params)

    if @document.save
      @document.transcription_xml.xml_to_json
      redirect_to doc_path, notice: "The files have been uploaded succesfully."
    else
      render 'new'
    end
  end

  def destroy
      @search = Search.find(params[:id])
      @document = TranscriptionXml.find(params[:id])
      title = @document.title
      @search.destroy
      @document.destroy
      redirect_to doc_path, notice:  "The document #{title} has been removed."
   end

  private
    def document_params
      params.require(:page_image).permit :image, transcription_xml_attributes: :xml
    end

end
