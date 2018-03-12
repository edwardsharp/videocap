require "sequel"

DB = Sequel.connect('sqlite://video-rsvp.db')

DB.create_table? :movies do
  primary_key :id
  column :name, :varchar
  column :youtube_link, :varchar
  column :created_at, :datetime
  column :video_data, :text
end

DB.create_table? :rsvps do
  primary_key :id
  column :name, :varchar
end
