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
            md5 = Digest::MD5.hexdigest(xml_paths.to_a.join(" ")+images_paths.to_a.join(" "))[0..6]
            zip_dir = "#{Rails.root}/public/download/#{md5}"
            # Check if archive already exist
            if not File.directory?(zip_dir)
              # Create "zip_dir" if does not exist
              FileUtils.mkdir_p(zip_dir)
              # Default archive name "archive.zip"
              zip_file_path =  "#{zip_dir}/archive.zip"

              Zip::File.open(zip_file_path, Zip::File::CREATE) do |zip_file|
                if (xml_paths)
                  zip_file.mkdir('Transcriptions')
                  xml_paths.each do |filename, path|
                    zip_file.add("Transcriptions/#{filename}", path)
                  end # xml_paths.each do |filename, path|
                end # if (xml_paths)
                if (images_paths)
                  zip_file.mkdir('Images')
                  images_paths.each do |filename, path|
                    zip_file.add("Images/#{filename}", path)
                  end # images_paths.each do |filename, path|
                end # if (images_paths)
              end # Zip::File.open(zip_file_path, Zip::File::CREATE) do |zip_file|
            end
            respond_to do |format|
              format.json { render json: {'type': 'success', 'msg': "Archive created.", 'url': "/download/#{md5}/archive.zip"} }
              format.js   { render :layout => false }
            end
        rescue
          respond_to do |format|
            format.json { render json: {'type': 'warning', 'msg': "Error: Files archiving failure."} }
            format.js   { render :layout => false }
          end
        end
    else
      respond_to do |format|
        format.json { render json: {'type': 'warning', 'msg': "Download error: No selected documents!"} }
        format.js   { render :layout => false }
      end
    end
  end
end
