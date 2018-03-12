require "./config/sequel"
require "./uploaders/video_uploader"

class Movie < Sequel::Model
  include VideoUploader::Attachment.new(:video)

  def before_create
    self.created_at ||= Time.now
    super
  end

  def get_youtube
    #well, wanted to this be after_create but not working, cuz shrinerb complainz about no url method :(
    if self.youtube_link and !self.video_data

      outdir = 'public/uploads/cache/'
      system "youtube-dl -o '#{outdir}%(title)s-%(id)s.%(ext)s' '#{self.youtube_link}'"
      filename = `youtube-dl --get-filename '#{self.youtube_link}'`
      #uploader = VideoUploader.new(:cache)
      p "ZOMG filename: public/uploads/cache/#{filename.strip}"
      #uploader.upload(File.open(filename.strip))
      # self.video = File.open filename.strip
      # self.save
      file = File.open "public/uploads/cache/#{filename.strip}"

      cache_uploader = VideoUploader.new(:cache)
      cached_file = cache_uploader.upload(file, action: :cache)

      store_uploader = VideoUploader.new(:store)
      result = store_uploader.upload(cached_file, action: :store)

    end
    super
  end

  def file_name
    "#{self.created_at.strftime('%b%e %l:%M%p')} #{self.name} "
  end

end
