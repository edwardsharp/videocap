require "./config/sequel"
require "./uploaders/video_uploader"

class Movie < Sequel::Model
  include VideoUploader::Attachment.new(:video)

  def before_create
    self.created_at ||= Time.now
    super
  end

  def file_name
    "#{self.created_at.strftime('%b%e %l:%M%p')} #{self.name} "
  end

end
