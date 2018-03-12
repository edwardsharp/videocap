require "./uploaders/tus_uploader"

class VideoUploader < TusUploader
  
  def process(io, context)
    begin
      io.metadata["record_name"] = context[:record].file_name
    rescue
    end
    return io
  end
end
