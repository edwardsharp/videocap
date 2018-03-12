require "shrine"
require "shrine/storage/file_system"
require "shrine/storage/tus"
#require "shrine/storage/google_drive_storage"
# store: Shrine::Storage::GoogleDriveStorage.new(prefix: "store")
# Shrine::Storage::GoogleDriveStorage.new(
#   prefix: "store",
#   google_drive_client_secret_path: "#{Rails.root}/config/gclient_secret.json",
#   drive_public_folder_id: 'AAAARRRRGGGBBBFFFFadsasdX',
#   google_drive_options: {
#         path: proc { |style| "#{id}_#{photo.original_filename}_#{style}" },
#       },
# )

Shrine.storages = {
  cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"),
  store: Shrine::Storage::FileSystem.new("public", prefix: "uploads/store"),
  tus:   Shrine::Storage::Tus.new,
}

Shrine.plugin :sequel
Shrine.plugin :logging
Shrine.plugin :cached_attachment_data
