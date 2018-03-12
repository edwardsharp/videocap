require "./uploaders/tus_uploader"

class VideoUploader < TusUploader
  
  def process(io, context)
    io.metadata["record_name"] = context[:record].file_name
    return io
  end
end
