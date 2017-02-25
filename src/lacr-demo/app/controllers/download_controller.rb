require 'zip'

class DownloadController < ApplicationController
  def index
    selected = params['selected']
      # If there are selected pages
      if selected
        images_paths = Set.new
        xml_paths = Set.new
        # For each selected page
        selected.each do |s|
          entry = selected[s]
          # Continue if volume and page are spacified
          if entry.key?("volume") and entry.key?("page")
            vol, page = entry['volume'], entry['page']

            img = PageImage.find_by_volume_and_page(vol, page)
            if img
              images_paths.add([img.image_identifier, img.image.path])
            end

            xml = Search.where('volume' => vol).rewhere('page' => page)
            if xml
              xml_file = xml[0].transcription_xml
              xml_paths.add([xml_file.xml_identifier, xml_file.xml.path])
            end

          end # if entry.key?("volume") and entry.key?("page")
        end # selected.each do |s|

        # Catch exceptions during archiving files
        begin

          filename = 'archive.zip'
          temp_file = Tempfile.new(filename)
          Zip::File.open(temp_file.path, Zip::File::CREATE) do |zip_file|
            if (xml_paths)
              zip_file.mkdir('Transcriptions')
              xml_paths.each do |filename, path|
                zip_file.add("Transcriptions/#{filename}", path)
              end # xml_paths.each
            end # if (xml_paths)
            if (images_paths)
              zip_file.mkdir('Images')
              images_paths.each do |filename, path|
                zip_file.add("Images/#{filename}", path)
              end # images_paths.each do |filename, path|
            end # if (images_paths)
          end # Zip::File.open

          # Sore the filepath in the session
          key = Random.rand("some random text".hash).to_s(36)[0, 6]
          session[:tmp_file] = {key => temp_file.path}

          respond_to do |format|
            format.json { render json: {'type': 'success', 'msg': "Archive created.", 'url': download_archive_path + "?key=#{key}" }}
            format.js   { render :layout => false }
          end # respond_to

        rescue
          respond_to do |format|
            format.json { render json: {'type': 'warning', 'msg': "Error: Files archiving failure."} }
            format.js   { render :layout => false }
          end # respond_to
        end # begin rescue
    else
      respond_to do |format|
        format.json { render json: {'type': 'warning', 'msg': "Download error: No selected documents!"} }
        format.js   { render :layout => false }
      end # respond
    end # if selected
  end # index

  def archive
      if params.has_key? "key"
        filepath = session[:tmp_file][params[:key]]
        if filepath
          begin
            zip_data = File.read(filepath)
            send_data(zip_data, :type => 'application/zip', :filename => 'archive.zip')
            return
          end # begin ensure
        end # if key
      end # params.has_key? "key"
      render file: "#{Rails.root}/public/404.html" , status: :not_found
  end # archive
end
