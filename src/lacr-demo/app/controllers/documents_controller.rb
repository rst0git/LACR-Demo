class DocumentsController < ApplicationController
  def index
    # @pages = PageImage.paginate(:page => params[:page], :per_page => 10)
    @documents = TranscriptionJsonParagraph.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    if params.has_key?(:id)
      # Retrieve the json record
      @document = TranscriptionJsonParagraph.find params[:id]
      # Get the image url
      @document_image_normal = @document.transcription_xml.page_image.image.normal.url
      @document_image_large = @document.transcription_xml.page_image.image.large.url
    else
      redirect_to doc_path, notice:  "The document has not been found."
    end
  end

  def new
    @document = PageImage.new
    @document.transcription_xml = TranscriptionXml.new
  end

  def upload
    # Create new PageImage instace
    @document = PageImage.new(document_params)
    # Store the foregin key
    @document.transcription_xml.page_image = @document

    if @document.save
      # Parse the XML file
      @document.transcription_xml.xml_to_json
      # Show all documets
      redirect_to doc_path, notice: "The files have been uploaded succesfully."
    else
      # Otherwise go back to new documets
      render 'new'
    end
  end

  def destroy
      @document = TranscriptionJsonParagraph.find(params[:id])
      @search = Search.find(params[:id])
      title = @document.title # Save the title before remove the records
      @search.destroy
      @document.destroy
      redirect_to doc_path, notice:  "The document #{title} has been removed."
   end

  private
    def document_params
      params.require(:page_image).permit :image, transcription_xml_attributes: :xml
    end

end
